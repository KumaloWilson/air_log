import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constant/colors.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 80,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: LoadingAnimationWidget.hexagonDots(
                  color: Pallete.primaryColor,
                  size: 45
              ),
            ),

            SizedBox(
              width: 20,
            ),

            Expanded(
              flex: 5,
              child: Text(
                '$message.....',
                style: TextStyle(
                  color: Pallete.primaryColor,
                  fontSize: 12
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
