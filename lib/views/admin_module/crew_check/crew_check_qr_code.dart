import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../helpers/flight_helpers.dart';

class AdminCrewCheckQRCodeGeneration extends StatefulWidget {
  const AdminCrewCheckQRCodeGeneration({super.key});

  @override
  State<AdminCrewCheckQRCodeGeneration> createState() => _AdminCrewCheckQRCodeGenerationState();
}

class _AdminCrewCheckQRCodeGenerationState extends State<AdminCrewCheckQRCodeGeneration> {

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
                showValue: false,
              ),
            )
        )
    );
  }
}
