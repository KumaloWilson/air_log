import 'dart:async';

import 'package:air_log/views/admin_module/navbar.dart';
import 'package:air_log/views/crew_member_module/crew_member_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../global/global.dart';
import '../views/universal_screens/authorization_screens/auth_handler.dart';
import '../views/universal_screens/authorization_screens/email_verification_screen.dart';
import '../views/universal_screens/authorization_screens/email_verification_success.dart';
import '../views/universal_screens/userRoleSelection/userRoleScreen.dart';
import 'helpers/genenal_helpers.dart';

class AuthHelpers {
  static Future<void> handleEmailVerification(BuildContext context, User user) async {
    if (!user.emailVerified) {
      Helpers.permanentNavigator(context, EmailVerificationScreen(user: user));
    } else {
      Helpers.permanentNavigator(context, const AuthHandler());
    }
  }

  static Future<void> checkEmailVerification({required BuildContext context, required User currentUser}) async {
    await currentUser.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      Helpers.permanentNavigator(context, const AuthHandler());
    }
  }

  static setTimerForAutoRedirect(BuildContext context) {
    const Duration timerPeriod = Duration(seconds: 5); // Change the timer period as needed
    Timer.periodic(
      timerPeriod,
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;

        if (user?.emailVerified ?? false) {
          Helpers.permanentNavigator(
              context, const AccountVerificationSuccessful());
          timer.cancel(); // Stop the timer once verification is successful
        }
      },
    );
  }

  static Future<String?> getCurrentUserToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? token = await user.getIdToken();
        return token;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user token: $e');
      return null;
    }
  }



  static Widget getSelectedUserRole() {
    switch (userRole) {
      case UserRole.crewMember:
        return const CrewMemberNavBar();
      case UserRole.admin:
        return const AdminNavBar();
      default:
        return const InitialRoleSelectionScreen();
    }
  }

}
