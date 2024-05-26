import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final user = FirebaseAuth.instance.currentUser;

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Container(
                height: 200,
                child: SfBarcodeGenerator(
                  value: user!.uid,
                  symbology: QRCode(),
                  showValue: true,
                ),
              )
          )
      ),
    );
  }
}
