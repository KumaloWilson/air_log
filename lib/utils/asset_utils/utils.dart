import 'package:flutter/material.dart';

class Utils{
  Utils();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  //if it doesnt work change to void method and remove utils instance
  static showSnackBar(String? text){
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.blue,);

    Utils newObj = new Utils();
    newObj.messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}