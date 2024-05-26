import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../helpers/shared_preferances_helper.dart';
import '../../../models/userprofile.dart';
import '../../../providers/userprofile_provider.dart';
import '../authorization_screens/auth_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  loadUserProfileDataFromLocalCache() async {
    final Logger logger = Logger();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    UserProfile? userProfile = await SharedPreferencesHelper.getUserProfileInformationFromCache();

    if (userProfile != null) {
      userProfileProvider.setUserProfile(userProfile);
      logger.i('cached userprofile found');
    }else{
      logger.w('cached userprofile found not found, fetch in the database please');
    }
  }


  @override
  void initState() {
    super.initState();

    ///LOAD USERPROFILE DATA
    loadUserProfileDataFromLocalCache();

  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: MyImageLocalAssets.logo,
      splashIconSize: 100,
      screenFunction: () async {
        return const AuthHandler();
      },
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
