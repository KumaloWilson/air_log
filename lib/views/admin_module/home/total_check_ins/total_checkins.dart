import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../api_services/flight_services/chat_services.dart';
import '../../../../constant/colors.dart';
import '../../../../helpers/flight_helpers.dart';
import '../../../../models/flight_check_in_model.dart';
import '../../../widgets/custom_text_field.dart';

class TotalCheckInsScreen extends StatefulWidget {
  const TotalCheckInsScreen({super.key});

  @override
  _TotalCheckInsScreenState createState() => _TotalCheckInsScreenState();
}

class _TotalCheckInsScreenState extends State<TotalCheckInsScreen> {
  late Future<List<CrewScheduleEntry>> _checkInsFuture;
  String _selectedDate = FlightHelpers.getTodayDateString();
  String _searchQuery = '';
  List<CrewScheduleEntry> checkIns = [];
  @override
  void initState() {
    super.initState();
    _checkInsFuture = FlightServices.getCheckInsByDate(_selectedDate);
  }

  void _searchCheckIns(String? query) {
    setState(() {
      _searchQuery = query!;
    });
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
        _checkInsFuture = FlightServices.getCheckInsByDate(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        title: const Text(
          'CheckIns',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Pallete.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),

          IconButton(
            icon: const Icon(Icons.download),
            onPressed: ()=> _exportToExcel(checkIns),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            decoration: const BoxDecoration(
              color: Pallete.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Pallete.primaryColor.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(-1, -1),
                              ),
                              BoxShadow(
                                color: Colors.white24,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ]),
                        child: CustomTextField(
                          labelText: 'Search surname',
                          labelStyle: TextStyle(
                              color: Pallete.primaryColor.withOpacity(0.5)),
                          defaultBoarderColor: Pallete.primaryColor,
                          focusedBoarderColor: Colors.transparent,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Pallete.primaryColor.withOpacity(0.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          onChanged: _searchCheckIns,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<CrewScheduleEntry>>(
                future: _checkInsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Pallete.primaryColor));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No check-ins found'));
                  } else {
                     checkIns = snapshot.data!;
                    if (_searchQuery.isNotEmpty) {
                      checkIns = checkIns.where((entry) =>
                          entry.surname.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
                    }
                    return ListView.builder(
                      itemCount: checkIns.length,
                      itemBuilder: (context, index) {
                        CrewScheduleEntry entry = checkIns[index];
                        return ListTile(
                          title: Text(entry.surname, style: const TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(
                            "Date: ${formatTimestamp(entry.checkInTime, 'yyyy/MM/dd')}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                            ),
                          ),
                          trailing: Text(
                            "Time\n${formatTimestamp(entry.checkInTime, 'HH:mm')}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp, String format) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }


  Future<void> _exportToExcel(List<CrewScheduleEntry> checkIns) async {
    // Create a new Excel Document.
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    // Add headers.
    sheet.getRangeByName('A1').setText('Flight No');
    sheet.getRangeByName('B1').setText('Surname');
    sheet.getRangeByName('C1').setText('Staff Number');
    sheet.getRangeByName('D1').setText('Check In');
    sheet.getRangeByName('E1').setText('Signature');
    sheet.getRangeByName('F1').setText('Check Out');
    sheet.getRangeByName('G1').setText('Signature');

    // Add data.
    for (int i = 0; i < checkIns.length; i++) {
      final entry = checkIns[i];
      sheet.getRangeByName('A${i + 2}').setText(entry.flightNo);
      sheet.getRangeByName('B${i + 2}').setText(entry.surname);
      sheet.getRangeByName('C${i + 2}').setText(entry.staffNumber);
      sheet.getRangeByName('D${i + 2}').setText(formatTimestamp(entry.checkInTime, 'HH:mm').toString());
      sheet.getRangeByName('E${i + 2}').setText(entry.signatureIn);
      sheet.getRangeByName('F${i + 2}').setText(entry.checkOutTime != null ? formatTimestamp(entry.checkOutTime!, 'HH:mm').toString() : '');
      sheet.getRangeByName('G${i + 2}').setText(entry.signatureOut);
    }

    // Save the document.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Get the path to save the file.
    final directory = await getDownloadsDirectory();
    final path = '${directory!.path}/CheckIns_${_selectedDate}.xlsx';
    final file = File(path);

    // Write the bytes to the file.
    await file.writeAsBytes(bytes, flush: true);

    // Provide feedback to the user.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel file saved at $path')),
    );
  }

}
