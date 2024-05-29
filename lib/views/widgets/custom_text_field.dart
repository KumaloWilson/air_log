import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class CustomTextField extends StatelessWidget {
  Color? fillColor;
  bool? filled;
  Color? focusedBoarderColor;
  Color? defaultBoarderColor;
  TextEditingController? controller;
  final String? labelText;
  final void Function(String?)? onChanged;
  final bool? obscureText;
  final TextStyle? labelStyle;
  final TextStyle? inputTextStyle;
  final TextInputType? keyBoardType;
  final Icon? prefixIcon;
  int? maxLength;
  Widget? suffixIconButton;
  bool? enabled;

  CustomTextField({super.key, this.maxLength, this.controller, this.fillColor, this.filled, this.defaultBoarderColor, this.focusedBoarderColor, required this.labelText, this.labelStyle, this.inputTextStyle, this.keyBoardType, required this.prefixIcon, this.obscureText, this.suffixIconButton, this.enabled, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      keyboardType: keyBoardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled ?? true,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled ?? false,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey,
        suffixIcon: suffixIconButton,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: defaultBoarderColor ?? Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: defaultBoarderColor ?? Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: focusedBoarderColor ?? Pallete.primaryColor),
        ),

        labelText: labelText ?? '',
        labelStyle: labelStyle ?? TextStyle(
          color: Colors.grey,
          fontSize: 12
        ),
      ),
      style: inputTextStyle ??  TextStyle(
          color: Pallete.primaryColor,
          fontSize: 12
      ),

    );
  }
}
