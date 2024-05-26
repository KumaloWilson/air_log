import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:air_log/views/universal_screens/authorization_screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../custom_animations/fade_in_slide.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text_field.dart';
import 'forgotPasswordScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FadeInSlide(
                duration: 1.0,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 100,
                  child: Image.asset(MyImageLocalAssets.logo),
                )),
            const SizedBox(
              height: 20,
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
                  FadeInSlide(
                    duration: 1.2,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Pallete.lightPrimaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeInSlide(
                    duration: 1.4,
                    child: CustomTextField(
                      controller: emailController,
                      labelText: 'Email Address',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FadeInSlide(
                    duration: 1.6,
                    child: CustomTextField(
                      controller: passwordController,
                      obscureText: true,
                      labelText: 'password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FadeInSlide(
                    duration: 1.8,
                    child: CustomButton(
                        btnColor: Pallete.primaryColor,
                        width: screenWidth,
                        borderRadius: 10,
                        child: Text(
                          'Log In',
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
                                    message: 'Logging in');
                              });

                          await AuthServices.login(
                              context: context,
                              emailAddress: emailController.text.trim(),
                              password: passwordController.text.trim());
                        }),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeInSlide(
                    duration: 2.2,
                    child: GestureDetector(
                      onTap: () => Helpers.temporaryNavigator(
                          context, ForgotPasswordScreen()),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 12,
                                color: Pallete.lightPrimaryTextColor),
                            children: [
                              TextSpan(
                                  text: "Forgot Password?",
                                  style: TextStyle(
                                      color: Pallete.primaryColor,
                                      fontWeight: FontWeight.w400))
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                FadeInSlide(
                  duration: 2.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: const Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        ' Login with',
                        style: TextStyle(
                            color: Pallete.lightPrimaryTextColor, fontSize: 12),
                      ),
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: const Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FadeInSlide(
                  duration: 2.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return const CustomLoader(
                                    message: 'Logging in');
                              });
                          await AuthServices.signInWithGoogle();
                        },
                        child: Image.asset(
                          MyImageLocalAssets.googleIcon,
                          width: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        size: 40,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Icon(
                        FontAwesomeIcons.apple,
                        size: 40,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                FadeInSlide(
                  duration: 2.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.42,
                        child: const Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'or',
                        style: TextStyle(color: Pallete.lightPrimaryTextColor),
                      ),
                      SizedBox(
                        width: screenWidth * 0.42,
                        child: const Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FadeInSlide(
                  duration: 3.0,
                  child: GestureDetector(
                    onTap: () =>
                        Helpers.permanentNavigator(context, const SignUp()),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 12,
                              color: Pallete.lightPrimaryTextColor),
                          children: [
                            const TextSpan(text: "Don't have an Account? "),
                            TextSpan(
                                text: " Register",
                                style: TextStyle(
                                    color: Pallete.primaryColor,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FadeInSlide(
                  duration: 3.2,
                  child: Text(
                    'By proceeding you consent to get calls, WhatsApp or SMS messages including by automated means from Markiti and its affiliated to the number provided',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Pallete.lightPrimaryTextColor, fontSize: 9.61),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
