import 'package:air_log/utils/asset_utils/animation_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant/colors.dart';
import '../custom_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  CustomConfirmationDialog({super.key, required this.message, required this.onYesConfirmTap, required this.onNoTap, required this.yesConfirmText, required this.noText});
  final String message;
  final String yesConfirmText;
  final String noText;
  final void Function() onYesConfirmTap;
  final void Function() onNoTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
                AnimationAssets.areYouSureAnimation,
                width: 100,
                repeat: false
            ),
            const SizedBox(
              height: 16,
            ),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 10
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                Expanded(flex: 1,child: Container()),
                Expanded(
                  flex: 3,
                  child: CustomButton(
                      btnColor: Theme.of(context).disabledColor,
                      width: double.infinity,
                      borderRadius: 10,
                      onTap: onNoTap,
                      child: Text(
                        noText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ),

                Expanded(flex: 1,child: Container()),

                Expanded(
                  flex: 3,
                  child: CustomButton(
                      btnColor: Pallete.primaryColor,
                      width: double.infinity,
                      borderRadius: 10,
                      onTap: onYesConfirmTap,
                      child: Text(
                        yesConfirmText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
                Expanded(flex: 1,child: Container()),
              ],
            )

          ],
        ),
      ),
    );
  }
}
