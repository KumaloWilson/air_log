import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../custom_animations/fade_in_slide.dart';
import '../custom_button.dart';

class OnUpDatePhoneNumberDialog extends StatefulWidget {
  const OnUpDatePhoneNumberDialog({super.key, required this.message, required this.onYesConfirmTap, required this.onNoTap, required this.yesConfirmText, required this.noText, required this.textFieldLabelText, required this.prefixIcon, required this.phoneNumberController});
  final String message;
  final String yesConfirmText;
  final String noText;
  final String textFieldLabelText;
  final IconData prefixIcon;
  final PhoneNumberInputController? phoneNumberController;
  final void Function() onYesConfirmTap;
  final void Function() onNoTap;

  @override
  State<OnUpDatePhoneNumberDialog> createState() => _OnUpDatePhoneNumberDialogState();
}

class _OnUpDatePhoneNumberDialogState extends State<OnUpDatePhoneNumberDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              MyImageLocalAssets.logo,
              width: 100,
            ),
            SizedBox(
              height: 16,
            ),

            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 10
              ),
            ),

            SizedBox(
              height: 16,
            ),

            FadeInSlide(
              duration: 1.8,
              child: PhoneNumberInput(
                initialCountry: 'ZW',
                locale: 'fr',
                errorText: 'Invalid Phone Number',
                controller: widget.phoneNumberController,
                countryListMode: CountryListMode.bottomSheet,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Pallete.primaryColor)
                ),
                allowPickFromContacts: false,
                inputTextStyle: TextStyle(
                    color: Pallete.primaryColor, fontSize: 12
                ),
              ),
            ),

            SizedBox(
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
                      onTap: widget.onNoTap,
                      child: Text(
                        widget.noText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      onTap: widget.onYesConfirmTap,
                      child: Text(
                        widget.yesConfirmText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
