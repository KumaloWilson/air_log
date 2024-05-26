
import 'package:air_log/models/userprofile.dart';
import 'package:air_log/views/universal_screens/authorization_screens/personal_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../api_services/userprofile_services/userprofile_services.dart';
import '../../../global/global.dart';
import '../../../helpers/auth_helpers.dart';
import '../../../helpers/shared_preferances_helper.dart';
import '../../../main.dart';
import '../../../providers/userprofile_provider.dart';
import '../../widgets/custom_loader.dart';
import '../welcomePage.dart';
import 'login.dart';

class AuthHandler extends StatefulWidget {
  const AuthHandler({super.key});

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {

  late UserProfileProvider userProfileProvider;
  late UserProfile? userProfileData;
  final user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    fetchProfileDataFromDatabase();
  }


  fetchProfileDataFromDatabase() async {
    userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);

    setState(() {
      userProfileData = userProfileProvider.userProfile;
    });

    if (userProfileData == null && user != null) {
      final userStoredProfile = await UserProfileServices.fetchUserProfileInformation(user!.uid);

      if (userStoredProfile != null) {
        await SharedPreferencesHelper.saveUserProfileToCache(userStoredProfile);
        userProfileProvider.setUserProfile(userStoredProfile);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomLoader(
                    message: 'Loading Profile'
                ),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          final user = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UserProvider>(context, listen: false).updateUser(user);
            if (!user.emailVerified) {
              AuthHelpers.handleEmailVerification(context, user);
            }
          });


          if(userProfileData == null){
            return AdditionalPersonalInfoScreen(userId: user.uid);
          }




          return AuthHelpers.getSelectedUserRole();
        } else {
          return userRole != null
              ? (hasSeenOnboarding!
                  ? const Login()
                  : WelcomePage(selectedRole: userRole!))
              : AuthHelpers.getSelectedUserRole();
        }
      },
    );
  }
}
