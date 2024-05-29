import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../utils/asset_utils/animation_assets.dart';
import '../../widgets/custom_button.dart';
import 'auth_handler.dart';

class AccountVerificationSuccessful extends StatelessWidget {
  const AccountVerificationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    String? sentTo;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(AnimationAssets.successfulAnimation, width: 200),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Verification Successful',
                    style: TextStyle(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 8,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Congratulations your account has been activated.Continue to start Shopping and Experience a world of unrivaled Deals and personalized Offers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      btnColor: Pallete.primaryColor,
                      width: screenWidth,
                      borderRadius: 10,
                      child: Text(
                        'Continuee',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () =>
                          Helpers.permanentNavigator(context, AuthHandler())),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
