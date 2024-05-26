import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInStatus {
  final bool isCheckedIn;
  final Timestamp? checkInTime;
  final Timestamp? checkOutTime;

  CheckInStatus({
    required this.isCheckedIn,
    this.checkInTime,
    this.checkOutTime,
  });

  factory CheckInStatus.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CheckInStatus(
      isCheckedIn: data['isCheckedIn'] ?? false,
      checkInTime: data['checkInTime'] ?? Timestamp.now(),
      checkOutTime: data['checkOutTime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'isCheckedIn': isCheckedIn,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
    };
  }
}
