import 'package:air_log/utils/asset_utils/animation_assets.dart';
import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';

class IntroPage1 extends StatelessWidget {
  final UserRole selectedRole;
  const IntroPage1({Key? key, required this.selectedRole}) : super(key: key);

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
            Lottie.asset(AnimationAssets.registration,
                fit: BoxFit.fill, height: 350),
            Text(
              selectedRole == UserRole.admin
                  ? 'Register\nTo Get started your Crew'
                  : selectedRole == UserRole.crewMember
                      ? 'Register\nTo Get started with automated check in'
                          : '',

              ///PLEASE REPLACE WITH A TEXT

              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 8
              ),
            )
          ],
        ),
      ),
    );
  }
}
