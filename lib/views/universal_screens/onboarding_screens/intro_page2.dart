import 'package:air_log/utils/asset_utils/animation_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';

class IntroPage2 extends StatelessWidget {
  final UserRole selectedRole;
  const IntroPage2({
    Key? key,
    required this.selectedRole,
  }) : super(key: key);

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
                selectedRole == UserRole.admin
                    ? AnimationAssets.deliveryAnimation
                    : selectedRole == UserRole.crewMember
                        ? AnimationAssets.behalfOrder
                            : AnimationAssets.applicationReviewAnimation,

                ///PLEASE REPLACE WITH A PROPER ANIMATION
                fit: BoxFit.fill,
                height: 350),
            Text(
              selectedRole == UserRole.admin
                  ? 'Navigate to your\nDestination points using your Device'
                  : selectedRole == UserRole.crewMember
                      ? 'Remote Services\nGet our services from the comfort of your home'
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
