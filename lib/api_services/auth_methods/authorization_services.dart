import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:air_log/api_services/chat_services/chat_services.dart';
import 'package:air_log/api_services/mail_services/mail_services.dart';
import 'package:air_log/api_services/notifications_services/notification_services.dart';
import 'package:air_log/api_services/role_services/role_services.dart';
import 'package:air_log/api_services/userprofile_services/userprofile_services.dart';
import 'package:air_log/global/global.dart';
import 'package:air_log/helpers/shared_preferances_helper.dart';

import '../../helpers/helpers/genenal_helpers.dart';

class AuthServices {
  static final Logger _logger = Logger();

  // sign up with email and password
  static Future<String?> signUpWithVerification(
      {String? profilePic,
      required String emailAddress,
      required String password,
      required String userName,
      required String userRole,
      required String fcmToken}) async {
    try {
      // Step 1: Create user with email and password
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Step 2: Send verification email
      await userCredential.user!.sendEmailVerification();

      // After user registration is successful, update the user's profile
      await userCredential.user!.updateDisplayName(userName);

      // Step 4: Set custom claim for user role
      final String? userToken = await userCredential.user!.getIdToken();

      await RoleServices.sendUserRoleAndFCMTokenByUserRegistrationToken(userToken: userToken ?? '', userRole: userRole, fcmToken: fcmToken);

      return 'success';
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email Address already in use';
        case 'weak-password':
          return 'Your password is weak';
        default:
          return'Unknown error please contact Support';
      }
    } catch (e) {
      // Handle other unforeseen errors
      rethrow; // Rethrow the original error for broader handling
    }
  }

  static Future<void> login({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    try {
      final loginResponse =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      Helpers.back(context);

      // Handle successful login (optional, remove if not needed)
      _logger.i('Login successful: ${loginResponse.user!.email}');

      if (loginResponse.user != null) {
        await validateUserAndCheckRolesAndFCMToken(loginResponse.user);
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      switch (e.code) {
        case 'invalid-email':
          Fluttertoast.showToast(msg: 'Invalid email address format.');
          throw const AuthException('Invalid email address format.');
        case 'user-disabled':
          Fluttertoast.showToast(msg: 'User account is disabled');
          throw const AuthException('User account is disabled.');
        case 'user-not-found':
          Fluttertoast.showToast(msg: 'No user found for that email');
          throw const AuthException('No user found for that email.');
        case 'wrong-password':
          Fluttertoast.showToast(msg: 'Incorrect password');
          throw const AuthException('Incorrect password provided.');
        default:
          Fluttertoast.showToast(msg: 'Unknown error, Please Contact Support');
          throw AuthException(
              'Unknown Firebase authentication error: ${e.message}');
      }
    } catch (e) {
      // Handle other unforeseen errors
      rethrow; // Rethrow the original error for broader handling
    }
  }

// Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        // Obtain auth details from request
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Create a new credential for the user
        final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Check if the user already exists
        final existingUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (existingUser.user != null) {
          await validateUserAndCheckRolesAndFCMToken(existingUser.user);
          return existingUser;
        } else {
          final newUser =
              await FirebaseAuth.instance.signInWithCredential(credential);

          final String? userToken = await newUser.user!.getIdToken();
          final currentRole = userRole.toString().split('.').last;
          final String? fcmToken =
              await NotificationServices.getFCMDeviceToken();

          await RoleServices.sendUserRoleAndFCMTokenByUserRegistrationToken(
              userToken: userToken ?? '',
              userRole: currentRole,
              fcmToken: fcmToken ?? '');

          return newUser;
        }
      } else {
        // User canceled sign-in process
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      _logger.e("Error signing in with Google: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> validateUserAndCheckRolesAndFCMToken(User? user) async {
    final idTokenResult = await user!.getIdTokenResult();
    dynamic userClaims = idTokenResult.claims;
    _logger.i('User claims: $userClaims');

    if (userClaims != null) {
      // Extract roles from user claims
      final currentRole = userRole.toString().split('.').last;

      await RoleServices.checkIfCurrentCachedRoleIsRegisteredInCustomClaims(
          userClaims, currentRole);

      /// SEND USER EMAIL THAT HE HAS LOGGED IN SUCCESSFULLY
      await MailServices.sendEmailAfterSuccessfulLogin(
          email: user.email.toString(), username: user.displayName.toString());

      String? newFCMToken = await NotificationServices.refreshFCMToken();

      if (newFCMToken != null) {
        await NotificationServices.updateFCMTokenOnLogin(
          uid: user.uid,
          fcmToken: newFCMToken,
        );

        //await FlightServices.updateParticipantFcmTokenInTheDB(participantId: user.uid, updatedFcmToken: newFCMToken);
      }
    } else {
      _logger.e('USER ROLE NOT SET');
      return;
    }
  }
}

// Custom AuthException class for better error handling
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
