import 'package:air_log/constant/colors.dart';
import 'package:air_log/helpers/helpers/genenal_helpers.dart';
import 'package:air_log/utils/asset_utils/image_assets.dart';
import 'package:air_log/views/crew_member_module/home/qr_scanner.dart';
import 'package:air_log/views/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:one_clock/one_clock.dart';

import '../../../api_services/chat_services/chat_services.dart';
import '../../../models/check_in_status.dart';
import '../../../models/flight_check_in_model.dart';
import 'check_out_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  CheckInStatus? _checkInStatus;
  bool _isLoading = true;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _fetchCheckInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        automaticallyImplyLeading: false,
        title: ListTile(
          leading: const CircleAvatar(),
          title: const Text(
            'Good Morning!!',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          subtitle: Text(
            user!.displayName ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.asset(MyImageLocalAssets.logo),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _checkInStatus?.isCheckedIn ?? false ? 'Check Out' : 'Check In Now',
                    style: TextStyle(
                      color: Pallete.lightPrimaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: AnalogClock(
                    width: 120,
                    height: 120,
                    isLive: true,
                    decoration: const BoxDecoration(
                      color: Pallete.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    datetime: DateTime.now(),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              btnColor: Pallete.primaryColor,
              width: 300,
              borderRadius: 10,
              onTap: () {
                if (_checkInStatus?.isCheckedIn ?? false) {
                  Helpers.temporaryNavigator(context, const QRScannerCheckOutScreen());
                } else {
                  Helpers.temporaryNavigator(context, const QRScannerCheckInScreen());
                }
              },
              child: Text(
                _checkInStatus?.isCheckedIn ?? false ? 'Check Out' : 'Check In Now',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Future<void> _fetchCheckInStatus() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('crewSchedule')
          .where('uid', isEqualTo: user!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          _checkInStatus = CheckInStatus.fromFirestore(snapshot.docs.first);
        });
      } else {
        setState(() {
          _checkInStatus = CheckInStatus(isCheckedIn: false);
        });
      }

      _checkIfUserIsLate(_checkInStatus);
    } catch (e) {
      _logger.e('Error fetching check-in status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkIfUserIsLate(CheckInStatus? status) {
    if (status == null || !status.isCheckedIn) {
      final now = DateTime.now();
      final eightAM = DateTime(now.year, now.month, now.day, 8, 0);
      if (now.isAfter(eightAM)) {
        final difference = now.difference(eightAM);
        final hoursLate = difference.inHours;
        final minutesLate = difference.inMinutes % 60;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Wake Up Alert!'),
                content: Text('You are $hoursLate hours and $minutesLate minutes late for wake.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      }
    }
  }
  

}
