import 'package:air_log/views/universal_screens/authorization_screens/resendResetEmalScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../utils/asset_utils/animation_assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 120,
              backgroundColor: Colors.transparent,
              child: Lottie.asset(
                AnimationAssets.resetPasswordAnimation,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter your email and we will send you a password reset link',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: emailController,
                    obscureText: false,
                    labelText: 'Email Address',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    btnColor: Pallete.primaryColor,
                    width: screenWidth,
                    borderRadius: 10,
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const CustomLoader(
                                message: 'Resetting Password');
                          });

                      await AuthServices.sendPasswordResetEmail(
                          email: emailController.text.trim());

                      Helpers.back(context);

                      Helpers.temporaryNavigator(
                          context,
                          ResendResetEmailScreen(
                              email: emailController.text.trim()));
                    },
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
