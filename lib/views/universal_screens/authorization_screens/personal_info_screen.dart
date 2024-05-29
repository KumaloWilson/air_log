import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../helpers/helpers/genenal_helpers.dart';
import '../../../providers/user_provider.dart';
import '../../custom_animations/fade_in_slide.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/date_input_form_field.dart';
import '../../widgets/dialogs/error_dialog.dart';
import 'address_screen.dart';

class AdditionalPersonalInfoScreen extends StatefulWidget {
  final String userId;
  const AdditionalPersonalInfoScreen({super.key, required this.userId});

  @override
  State<AdditionalPersonalInfoScreen> createState() =>
      _AdditionalPersonalInfoScreenState();
}

class _AdditionalPersonalInfoScreenState
    extends State<AdditionalPersonalInfoScreen> {
  final TextEditingController firstNameController = TextEditingController();

  PhoneNumberInputController? phoneNumberController;

  final TextEditingController lastNameController = TextEditingController();


  final TextEditingController staffNumberController = TextEditingController();


  final TextEditingController dateController = TextEditingController();

  String? selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    phoneNumberController = PhoneNumberInputController(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Let's get\nStarted",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tell us a bit more about yourself and\n we'll get you started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Divider(
                      thickness: 5,
                      color: Pallete.primaryColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.rectangle,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Divider(
                      thickness: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 500,
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Personal\nInformation',
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Enter your name as it appears on your National Identity Card',
              style: TextStyle(
                color: Pallete.lightPrimaryTextColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: firstNameController,
              labelText: 'First Name',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
              controller: lastNameController,
              labelText: 'Last Name',
              obscureText: false,
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
              controller: staffNumberController,
              labelText: 'Staff Number',
              obscureText: false,
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FadeInSlide(
              duration: 1.8,
              child: PhoneNumberInput(
                initialCountry: 'ZW',
                locale: 'fr',
                errorText: 'Invalid Phone Number',
                controller: phoneNumberController,
                countryListMode: CountryListMode.bottomSheet,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Pallete.primaryColor)),
                allowPickFromContacts: false,
                inputTextStyle:
                    const TextStyle(color: Pallete.primaryColor, fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomDateInputFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              format: 'dd/MM/yyyy',
              controller: dateController,
              scrollPadding: EdgeInsets.zero,
              style: const TextStyle(color: Pallete.primaryColor, fontSize: 12),
              decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Pallete.primaryColor),
                  ),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(Icons.date_range)),
            ),
            GenderPickerWithImage(
              showOtherGender: true,
              verticalAlignedText: true,
              selectedGender: Gender.Male,
              selectedGenderTextStyle: const TextStyle(
                  color: Pallete.primaryColor, fontWeight: FontWeight.bold),
              unSelectedGenderTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal),
              onChanged: (Gender? gender) {
                selectedGender = gender.toString().split('.').last;
              },
              equallyAligned: true,
              animationDuration: const Duration(milliseconds: 300),
              isCircular: true,
              // default : true,
              opacityOfGradient: 0.4,
              padding: const EdgeInsets.all(3),
              size: 50, //default : 40
            ),
            const SizedBox(height: 8),
            CustomButton(
                btnColor: Pallete.primaryColor,
                width: screenWidth,
                borderRadius: 10,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () => validateAndSubmitForm()),
            const SizedBox(
              height: 300,
            )
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    if (firstNameController.text.isEmpty) {
      showErrorDialog('First Name is required.');
      return;
    }

    if (firstNameController.text.length < 3) {
      showErrorDialog('First Name is too short');
      return;
    }

    if (lastNameController.text.isEmpty) {
      showErrorDialog('Last Name is required.');
      return;
    }

    if (lastNameController.text.length < 3) {
      showErrorDialog('Last Name is too short');
      return;
    }

    if (staffNumberController.text.length < 3) {
      showErrorDialog('Last Name is too short');
      return;
    }

    if (dateController.text.trim().length < 10) {
      showErrorDialog('Please use dd/MM/yyyy Format for your Date of Birth');
      return;
    }

    if (dateController.text.trim().length > 10) {
      showErrorDialog('Invalid Date of Birth');
      return;
    }

    if (!Helpers.isNumeric(phoneNumberController!.phoneNumber.toString())) {
      showErrorDialog('Please enter a valid phone number');
      return;
    }

    // If all validations pass, submit the form
    Helpers.temporaryNavigator(
        context,
        UserAddressScreen(
            userId: widget.userId,
            email: userProvider.user!.email ?? '',
            username: userProvider.user!.email ?? '',
            phoneNumber: phoneNumberController!.fullPhoneNumber.toString(),
            fullName:
                '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
            dob: dateController.text.trim(),
            staffNumber: staffNumberController.text,
            gender: selectedGender!
        )
    );
  }
}
