import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../helpers/flight_helpers.dart';
import '../../models/flight_check_in_model.dart';

class FlightServices {
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger();

  static Future<String> checkIn(CrewScheduleEntry entry) async {
    try {
      // Get current date in YYYY-MM-DD format
      final String today = FlightHelpers.getTodayDateString();

      // Get the collection reference for today's date
      final CollectionReference crewScheduleCollection = _firebaseFirestore.collection('crewSchedule').doc(today).collection('entries');

      // Adding the current date to the entry
      await crewScheduleCollection.add(entry.toJson());
      _logger.i('Check-in successful');
      return 'success';
    } catch (e) {
      _logger.e('Error while checking in: $e');
      return e.toString();
    }
  }

  static Future<String> checkout({required String uid, required String signatureOut}) async {
    try {
      // Get current date in YYYY-MM-DD format
      final String today = FlightHelpers.getTodayDateString();

      // Get the collection reference for today's date
      final CollectionReference crewScheduleCollection = _firebaseFirestore.collection('crewSchedule').doc(today).collection('entries');

      // Look for the entry with the provided uid
      final querySnapshot = await crewScheduleCollection
          .where('uid', isEqualTo: uid)
          .where('isCheckedIn', isEqualTo: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 'Crew member not found or already checked out.';
      }

      // Extract the document reference for the matching entry
      final document = querySnapshot.docs.single;

      // Update the CrewScheduleEntry with checkout info
      final updatedEntry = CrewScheduleEntry(
        uid: document['uid'],
        flightNo: document['flightNo'],
        surname: document['surname'],
        isCheckedIn: false,
        staffNumber: document['staffNumber'],
        checkInTime: document['checkInTime'],
        signatureIn: document['signatureIn'],
        checkOutTime: Timestamp.now(), // Set current timestamp for checkout
        signatureOut: signatureOut,
      );

      // Update the corresponding firestore entry with the new data
      await document.reference.update(updatedEntry.toJson());
      _logger.i('Check-out successful');
      return 'success';
    } catch (e) {
      _logger.e('Error while checking out: $e');
      return e.toString();
    }
  }

}