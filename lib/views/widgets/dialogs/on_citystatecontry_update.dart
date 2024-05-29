import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';

class OnUpDateDialog extends StatefulWidget {
  OnUpDateDialog({super.key, required this.message, required this.onYesConfirmTap, required this.onNoTap, required this.yesConfirmText, required this.noText, required this.textFieldLabelText, required this.prefixIcon, required this.textEditingController});
  final String message;
  final String yesConfirmText;
  final String noText;
  final String textFieldLabelText;
  final IconData prefixIcon;
  final TextEditingController textEditingController;
  final void Function() onYesConfirmTap;
  final void Function() onNoTap;

  @override
  State<OnUpDateDialog> createState() => _OnUpDateDialogState();
}

class _OnUpDateDialogState extends State<OnUpDateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(8),
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
              height: 8,
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
              height: 8,
            ),

            CustomTextField(
              labelText: widget.textFieldLabelText,
              prefixIcon: Icon(
                widget.prefixIcon,
                color: Colors.grey,
              ),
              controller: widget.textEditingController,
            ),

            SizedBox(
              height: 8,
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
