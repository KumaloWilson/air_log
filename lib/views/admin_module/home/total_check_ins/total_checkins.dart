import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                    List<CrewScheduleEntry> checkIns = snapshot.data!;
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
}
