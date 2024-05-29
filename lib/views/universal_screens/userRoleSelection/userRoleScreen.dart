import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../helpers/shared_preferances_helper.dart';
import '../../custom_animations/fade_in_slide.dart';
import '../../widgets/custom_button.dart';
import '../authorization_screens/auth_handler.dart';

class InitialRoleSelectionScreen extends StatefulWidget {
  const InitialRoleSelectionScreen({super.key});

  @override
  State<InitialRoleSelectionScreen> createState() =>
      _InitialRoleSelectionScreenState();
}

class _InitialRoleSelectionScreenState
    extends State<InitialRoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Pallete.primaryColor.withOpacity(0.6)
              ]
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyImageLocalAssets.logo,
                  width: 150,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Welcome to AirLog',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("What's your role ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Pallete.primaryColor,
                      fontSize: 8,
                      fontWeight: FontWeight.bold)),
              const Text("Please choose how you'd like to use our app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Pallete.primaryColor,
                    fontSize: 12,
                  )),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  FadeInSlide(
                    duration: 0.7,
                    child: Row(
                      children: [
                        Expanded(
                          child: roleWidget(
                              onTap: () => setState(() {
                                    userRole = UserRole.crewMember;
                                  }),
                              color: userRole == UserRole.crewMember
                                  ? Pallete.primaryColor
                                  : Colors.white,
                              textIconColour: userRole == UserRole.crewMember
                                  ? Colors.white
                                  : Pallete.primaryColor,
                              center: "Crew Member",
                              icon: FontAwesomeIcons.user),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: roleWidget(
                              onTap: () => setState(() {
                                    userRole = UserRole.admin;
                                  }),
                              color: userRole == UserRole.admin
                                  ? Pallete.primaryColor
                                  : Colors.white,
                              textIconColour: userRole == UserRole.admin
                                  ? Colors.white
                                  : Pallete.primaryColor,
                              center: "Admin",
                              icon: Icons.support_agent
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              FadeInSlide(
                duration: 2.0,
                child: CustomButton(
                    btnColor: userRole == null
                        ? Theme.of(context).disabledColor
                        : Pallete.primaryColor,
                    width: screenWidth,
                    borderRadius: 10,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onTap: () async {
                      if (userRole == null) {
                        Fluttertoast.showToast(msg: 'Please select a role');
                      } else {
                        await SharedPreferencesHelper.cacheUserRole(
                            role: userRole!
                        );
                        await SharedPreferencesHelper.checkOnBoardingStatus().then((value){
                          Helpers.permanentNavigator(context, const AuthHandler());
                        });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget roleWidget(
      {required Color color,
      required Color textIconColour,
      required void Function() onTap,
      required String center,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Pallete.primaryColor)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 60,
              color: textIconColour,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "$center\nCenter",
              textAlign: TextAlign.center,
              style: TextStyle(color: textIconColour, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
