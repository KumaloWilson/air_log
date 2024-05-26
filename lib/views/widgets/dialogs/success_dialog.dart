import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String successMessage;
  final void Function() onTap;
  const SuccessDialog({super.key, required this.successMessage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Success'),
      content: Text(successMessage),
      actions: [
        TextButton(
          onPressed: onTap,
          child: Text('OK'),
        ),
      ],
    );
  }
}
