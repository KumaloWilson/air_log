import 'package:air_log/helpers/flight_helpers.dart';
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/providers/plane_provider.dart';
import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:air_log/views/admin_module/crew_check/crew_check_qr_code.dart';
import 'package:air_log/views/admin_module/home/switch_plane/switch_plane.dart';
import 'package:air_log/views/admin_module/home/total_check_ins/total_checkins.dart';
import 'package:air_log/views/admin_module/home/total_employees/total_employees.dart';
import 'package:air_log/views/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../constant/colors.dart';
import '../../../utils/asset_utils/animation_assets.dart';
import '../../../utils/asset_utils/network_image_assets.dart';
import '../../custom_animations/fade_in_slide.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/dialogs/error_dialog.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final user = FirebaseAuth.instance.currentUser;
  late PlaneProvider planeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planeProvider = Provider.of<PlaneProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.primaryColor,
          automaticallyImplyLeading: false,
          title: ListTile(
            leading:  CircleAvatar(
              backgroundImage: NetworkImage(
                  user!.photoURL ?? MyNetworkImageAssets.defaultProfilePic
              ),
            ),
            title: const Text(
              'Good Morning!!',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),
            ),
            subtitle: Text(
              user!.displayName ?? MyNetworkImageAssets.defaultProfilePic,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              CircleAvatar(
                radius: 120,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  MyImageLocalAssets.logo,
                ),
              ),

              Text(
                "${planeProvider.planeNumber} : ${planeProvider.planeType}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Pallete.primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FadeInSlide(
                duration: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(

                        onTap: ()async{
                          bool isAuthorized = await reAuthenticateUser(route: AdminCrewCheckQRCodeGeneration(planeNumber: planeProvider.planeNumber,));
                        },
                        child: roleWidget(
                            color: Colors.white,
                            textIconColour: Pallete.primaryColor,
                            center: "Check (In/Out)\nCrew",
                            icon: FontAwesomeIcons.arrowRightToBracket
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          bool isAuthorized = await reAuthenticateUser(route: const AdminSwitchPlaneNumber());
                        },
                        child: roleWidget(
                            color: Colors.white,
                            textIconColour: Pallete.primaryColor,
                            center: "Switch\nPlane Number",
                            icon: FontAwesomeIcons.planeDeparture
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FadeInSlide(
                duration: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          bool isAuthorized = await reAuthenticateUser(route: const TotalEmployees());
                        },
                        child: roleWidget(
                            color: Colors.white,
                            textIconColour: Pallete.primaryColor,
                            center: "Crew Members",
                            icon: FontAwesomeIcons.users
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: ()async{
                          bool isAuthorized = await reAuthenticateUser(route: const TotalCheckInsScreen());
                        },
                        child: roleWidget(
                            color: Colors.white,
                            textIconColour: Pallete.primaryColor,
                            center: "View CheckIns",
                            icon: FontAwesomeIcons.calendar
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget roleWidget(
      {required Color color,
        required Color textIconColour,
        required String center,
        required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            "$center",
            textAlign: TextAlign.center,
            style: TextStyle(color: textIconColour, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }


  Future<bool> reAuthenticateUser({required Widget route}) async {
    final TextEditingController passwordController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;

    bool isAuthenticated = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                child: Lottie.asset(
                  AnimationAssets.createPasswordAnimation,
                ),
              ),

              Text(
                 'Please enter your password to continue.',
                style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 12
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              CustomTextField(
                labelText: 'Enter Password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                controller: passwordController,
                obscureText: true,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final credential = EmailAuthProvider.credential(
                    email: user!.email!,
                    password: passwordController.text,
                  );

                  if (passwordController.text.isEmpty) {
                    showErrorDialog('Password is required.');
                    return;
                  }

                  if (passwordController.text.length < 8) {
                    showErrorDialog('Password is too short');
                    return;
                  }

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const CustomLoader(message: 'Authenticating');
                      }
                  );

                  await user.reauthenticateWithCredential(credential);
                  isAuthenticated = true;
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Helpers.temporaryNavigator(context, route);

                } catch (e) {
                  Fluttertoast.showToast(msg:'Wrong Password\nPlease Try Again');
                  Navigator.of(context).pop();
                  print('Re-authentication failed: $e');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );

    return isAuthenticated;
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: errorMessage,
        ));
  }

}
