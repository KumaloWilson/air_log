import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../api_services/userprofile_services/userprofile_services.dart';
import '../../../constant/colors.dart';
import '../../../global/global.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../helpers/shared_preferances_helper.dart';
import '../../../models/userprofile.dart';
import '../../../providers/userprofile_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/dialogs/error_dialog.dart';
import 'auth_handler.dart';
import 'create_password.dart';

class UserAddressScreen extends StatefulWidget {
  final String userId;
  final String email;
  final String username;
  final String phoneNumber;
  final String fullName;
  final String dob;
  final String gender;
  final String staffNumber;

  const UserAddressScreen(
      {super.key,
      required this.userId,
      required this.email,
      required this.username,
      required this.phoneNumber,
      required this.fullName,
      required this.dob,
      required this.staffNumber,
      required this.gender});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Image.asset(MyImageLocalAssets.logo, width: 200),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Address',
                style: TextStyle(
                    color: Pallete.lightPrimaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Please Input your home address',
                style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
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
                    CustomTextField(
                      controller: addressController,
                      labelText: 'Address',
                      prefixIcon: const Icon(
                        Icons.location_city_sharp,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CSCPicker(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value.toString();
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value.toString();
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        btnColor: Pallete.primaryColor,
                        width: screenWidth,
                        borderRadius: 10,
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () => validateAndSubmitForm()),
                  ],
                ),
              )
            ],
          ),
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
    if (cityValue == null) {
      showErrorDialog('Please Select your City');
      return;
    }

    if (stateValue == null) {
      showErrorDialog('Please select your state');
      return;
    }

    if (countryValue == null) {
      showErrorDialog('Please select your country');
      return;
    }

    if (addressController.text.trim().isEmpty) {
      showErrorDialog('Please enter your address');
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return const CustomLoader(message: 'Creating Profile');
        });

    String role = userRole.toString().split('.').last;

    try {
      final response = await UserProfileServices.saveUserDetailsToFirestore(
        userId: widget.userId,
        fullName: widget.fullName,
        emailAddress: widget.email,
        phoneNumber: widget.phoneNumber,
        userRoles: [role],
        staffNumber: widget.staffNumber,
        dob: widget.dob,
        address: addressController.text.trim(),
        city: cityValue!,
        state: stateValue!,
        country: countryValue!,
      );

      await fetchProfileDataFromDatabase();

      if (mounted) {
        if (response == 'success') {
          Helpers.back(context);
          Helpers.permanentNavigator(context, const AuthHandler());
        } else {
          Helpers.back(context);
          showErrorDialog(response);
        }
      }
    } catch (error) {
      if (mounted) {
        Helpers.back(context);
        showErrorDialog(error.toString());
      }
    }

  }


  late UserProfileProvider userProfileProvider;
  late UserProfile? userProfileData;


  fetchProfileDataFromDatabase() async {
    userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);

    setState(() {
      userProfileData = userProfileProvider.userProfile;
    });

    if (userProfileData == null) {
      final user = FirebaseAuth.instance.currentUser;
      final userStoredProfile = await UserProfileServices.fetchUserProfileInformation(user!.uid);

      if (userStoredProfile != null) {
        await SharedPreferencesHelper.saveUserProfileToCache(userStoredProfile);
        userProfileProvider.setUserProfile(userStoredProfile);
      }
    }
  }
}
