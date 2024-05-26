import 'package:air_log/helpers/flight_helpers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final flightNumber = 'AIRZIM505${FlightHelpers.generateFlightNumber()}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SizedBox(
            height: 200,
            child: SfBarcodeGenerator(
              value: flightNumber,
              symbology: QRCode(),
              showValue: true,
            ),
          )
        )
    );
  }
}
