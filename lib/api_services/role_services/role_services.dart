import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:air_log/api_services/auth_methods/authorization_services.dart';
import '../../helpers/shared_preferances_helper.dart';
import '../../utils/configs/security_url_configs.dart';

class RoleServices {
  static final Logger _logger = Logger();
  // Function to send user role and token to server
  static Future<void> sendUserRoleAndFCMTokenByUserRegistrationToken(
      {required String userToken,
      required String userRole,
      required String fcmToken}) async {
    try {
      final String apiUrl = '${FirebaseSecurityConfig.baseUrl}/set_custom_claims';

      _logger.i("THIS IS YOUR FCM: ${fcmToken.toString()}");

      final Map<String, dynamic> body = {
        'token': userToken,
        'roles': userRole == 'crew_member'
            ? {'crew_member': true}
            : {userRole: true, 'admin': true},
        'fcmToken': fcmToken
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to set custom claims: ${response.body}');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Failed to set custom claims: $e');
    }
  }

  static Future<void> checkIfCurrentCachedRoleIsRegisteredInCustomClaims(
      final claims, final String currentRole) async {
    if (claims == null || claims['roles'] == null) {
      return;
    }

    final registeredRolesMap = claims['roles'] as Map?;
    if (registeredRolesMap != null) {
      if (registeredRolesMap.containsKey(currentRole) &&
          registeredRolesMap[currentRole] == true) {
      } else {
        // Unauthorized access - clear cache and sign out
        await SharedPreferencesHelper.clearCachedUserRole();
        await AuthServices.signOut();
        Fluttertoast.showToast(
            msg: "Unauthorized access. Please select your role and try again");
      }
    } else {
      _logger.e('ROLES NOT SET FROM USER CLAIMS. PLEASE FIX THIS');
    }
  }

  static Future<Map<String, dynamic>?> updateUserRole(
      {required String uid, required String newRole}) async {
    final String apiUrl =
        '${FirebaseSecurityConfig.baseUrl}/update_custom_claims';

    final url = Uri.parse(apiUrl);

    final header = {'Content-type': 'application/json'};

    final body = {
      'uid': uid,
      "newRoles": {newRole: true}
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
}
