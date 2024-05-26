import 'package:air_log/constant/colors.dart';
import 'package:air_log/global/global.dart';
import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:air_log/views/universal_screens/onboarding_screens/intro_page1.dart';
import 'package:air_log/views/universal_screens/onboarding_screens/intro_page2.dart';
import 'package:air_log/views/universal_screens/onboarding_screens/onboarding_screens.dart';
import 'package:air_log/views/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../helpers/helpers/genenal_helpers.dart';
import '../widgets/custom_button.dart';
import 'onboarding_screens/intro_page3.dart';

class WelcomePage extends StatelessWidget {
  final UserRole selectedRole;
  const WelcomePage({super.key, required this.selectedRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SizedBox(
          width: 250,
          child: MyLogo()
        )
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text(
              'Welcome to CovRe\n${Helpers.capitalizeFirstLetter(selectedRole.toString().split('.').last)} Center',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Pallete.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              btnColor: Pallete.primaryColor,
              width: MediaQuery.sizeOf(context).width,
              borderRadius: 10,
              onTap: () {
                Helpers.permanentNavigator(
                    context,
                    OnBoardingPage(
                        introPage1: IntroPage1(selectedRole: selectedRole),
                        introPage2: IntroPage2(selectedRole: selectedRole),
                        introPage3: IntroPage3(selectedRole: selectedRole),
                    )
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
