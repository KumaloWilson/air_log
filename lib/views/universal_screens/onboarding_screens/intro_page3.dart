import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';
import '../../../utils/asset_utils/animation_assets.dart';

class IntroPage3 extends StatelessWidget {
  final UserRole selectedRole;
  const IntroPage3({Key? key, required this.selectedRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                selectedRole == UserRole.crewMember
                    ? AnimationAssets.chatsAnimation
                    : selectedRole == UserRole.admin
                        ? AnimationAssets.chatsAnimation
                            : AnimationAssets.applicationReviewAnimation,

                ///PLEASE REPLACE WITH A PROPER ANIMATION
                fit: BoxFit.fill,
                height: 350
            ),

            Text(
              selectedRole == UserRole.crewMember
                  ? 'Ready ?\nWhat are you waiting for ?'
                  : selectedRole == UserRole.admin
                  ? 'Ready ?\nWhat are you waiting for ?'
                  : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 8),
            )
          ],
        ),
      ),
    );
  }
}
