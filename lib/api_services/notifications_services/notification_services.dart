import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:air_log/helpers/firebase_access_tokens.dart';
import '../../utils/configs/security_url_configs.dart';

class NotificationServices {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _flutterNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _logger = Logger();

  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );

    final notificationPlugin = FlutterLocalNotificationsPlugin();

    await notificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContent: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'platform_x_notification_channel',
      'platform_x_notification_channel',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await notificationPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['body'],
    );
  }

  static Future<void> requestNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _logger.i('USER GRANTED PERMISSION');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      _logger.i('USER GRANTED provisional PERMISSION');
    } else {
      _logger.e('NOTIFICATION PERMISSIONS DECLINED');
    }
  }

  static Future<String?> getFCMDeviceToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    _logger.i('FCM TOKEN: $fcmToken');
    return fcmToken;
  }

  static Future<String?> refreshFCMToken() async {
    await _firebaseMessaging.deleteToken();
    String? newToken = await _firebaseMessaging.getToken();
    return newToken;
  }

  static Future<Map<String, dynamic>?> updateFCMTokenOnLogin(
      {required String uid, required String fcmToken}) async {
    final String apiUrl =
        '${FirebaseSecurityConfig.baseUrl}/update_custom_claims';

    final url = Uri.parse(apiUrl);

    final header = {'Content-type': 'application/json'};

    final body = {
      'uid': uid,
      'fcmToken': fcmToken,
    };

    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return responseData;
      } else {
        _logger.e('Error updating custom claims: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      _logger.e('Error updating custom claims: $error');
      return null;
    }
  }

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  static Future<void> initInfo() async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    _flutterNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    /// While App is on the foreground

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _logger.i('-------------------onMessage-----------------------------');
      _logger.i(
          'onMessage: ${message.notification?.title}/${message.notification?.body}');

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContent: true);

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'platform_x_notification_channel',
        'platform_x_notification_channel',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const DarwinNotificationDetails());

      await _flutterNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  static Future<void> sendPushNotification(
      {required String fcmToken,
      required String notificationBody,
      required String notificationTitle}) async {
    final String projectId = FirebaseSecurityConfig.projectID.toString();

    // Construct the FCM endpoint URL with your project ID
    final String url =
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";

    final String accessToken = await FirebaseAccessTokens.getAccessToken();

    final requestBody = {
      "message": {
        "token": fcmToken,
        "notification": {"title": notificationTitle, "body": notificationBody},
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "done",
          "title": notificationTitle,
          "body": notificationBody
        }
      }
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        _logger.i('Notification sent successfully');
      } else {
        _logger.e(
            'Failed to send notification: ${response.statusCode}  ${jsonDecode(response.body)}');
      }
    } catch (e) {
      _logger.e('Error sending notification: $e');
    }
  }
}
