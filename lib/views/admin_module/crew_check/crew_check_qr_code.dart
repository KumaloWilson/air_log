import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../api_services/flight_services/chat_services.dart';
import '../../../constant/colors.dart';
import '../../../helpers/flight_helpers.dart';

class AdminCrewCheckQRCodeGeneration extends StatefulWidget {
  final String planeNumber;
  const AdminCrewCheckQRCodeGeneration({super.key, required this.planeNumber});

  @override
  State<AdminCrewCheckQRCodeGeneration> createState() => _AdminCrewCheckQRCodeGenerationState();
}

class _AdminCrewCheckQRCodeGenerationState extends State<AdminCrewCheckQRCodeGeneration> {
  late String flightNumber;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flightNumber = '${widget.planeNumber}${FlightHelpers.generateFlightNumber()}';
    _listenForNewEntries();
  }

  void _listenForNewEntries() {
    final String today = FlightHelpers.getTodayDateString();
    FlightServices.listenForCheckIn(today).listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final String surname = data['surname'];
        _greetUser(surname);
      }
    });
  }

  Future<void> _greetUser(String surname) async {
    await flutterTts.speak('Welcome, $surname');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Scan to Check In/Out',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Pallete.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, -5),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            height: 250,
            child: SfBarcodeGenerator(
              value: flightNumber,
              symbology: QRCode(),
              showValue: false,
            ),
          ),
        ),
      ),
    );
  }
}