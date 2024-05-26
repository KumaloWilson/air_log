import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CrewMemberNavBar extends StatefulWidget {
  const CrewMemberNavBar({super.key});

  @override
  State<CrewMemberNavBar> createState() => _CrewMemberNavBarState();
}

class _CrewMemberNavBarState extends State<CrewMemberNavBar> {

  final user = FirebaseAuth.instance.currentUser;

  void userProps(){
    user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
