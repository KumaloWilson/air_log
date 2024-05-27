import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../api_services/notifications_services/notification_services.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../utils/asset_utils/animation_assets.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogs/error_dialog.dart';
import 'auth_handler.dart';



class CreatePasswordScreen extends StatefulWidget {
  final String email;
  final String username;

  const CreatePasswordScreen({super.key, required this.email, required this.username});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String role = userRole.toString().split('.').last;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 120,
              backgroundColor: Colors.transparent,
              child: Lottie.asset(
                AnimationAssets.createPasswordAnimation,
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
                    'Create a Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Password should contain at least one\nuppercase, lowercase, number\n and special characters',
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
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Create a password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    labelText: 'Confirm password',
                    prefixIcon: const Icon(
                      Icons.lock,
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
                      'SignUp',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => validateAndSubmitForm(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
              errorMessage: errorMessage,
            ));
  }

  void validateAndSubmitForm() async {
    if (passwordController.text.isEmpty) {
      showErrorDialog('Password is required.');
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      showErrorDialog('Please Confirm your password.');
      return;
    }

    if (passwordController.text.length < 8) {
      showErrorDialog('Password is too short');
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      showErrorDialog('Passwords don`t Match');
      return;
    }

    if (!Helpers.isStrongPassword(confirmPasswordController.text.trim())) {
      showErrorDialog('Your password is too weak');
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const CustomLoader(message: 'Creating your Account');
        }
    );

    String? fcmToken = await NotificationServices.getFCMDeviceToken();

    String? signUpResponse = await AuthServices.signUpWithVerification(
        emailAddress: widget.email,
        password: confirmPasswordController.text.trim(),
        userName: widget.username,
        userRole: role,
        fcmToken: fcmToken ?? ''
    );

    if (signUpResponse != null) {
      getSignUpResponse(response: signUpResponse, context: context);
    } else {
      Helpers.back(context);
      showErrorDialog('An error occurred during sign-up.');
    }
  }
  
  void getSignUpResponse({required String response, required BuildContext context}){
    if(response == 'success'){
      Helpers.back(context);
      Helpers.permanentNavigator(context, const AuthHandler());
    }else{
      Helpers.back(context);
      showErrorDialog(response);
    }
  }
}
