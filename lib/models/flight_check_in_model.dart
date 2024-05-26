import 'package:cloud_firestore/cloud_firestore.dart';

class CrewScheduleEntry {
  String uid;
  String flightNo;
  String surname;
  bool isCheckedIn;
  String staffNumber;
  Timestamp checkInTime;
  String signatureIn;
  Timestamp? checkOutTime;
  String? signatureOut;

  CrewScheduleEntry({
    required this.uid,
    required this.flightNo,
    required this.surname,
    required this.isCheckedIn,
    required this.staffNumber,
    required this.checkInTime,
    required this.signatureIn,
    this.checkOutTime,
    this.signatureOut,
  });

  // Convert a CrewScheduleEntry into a Map.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'flightNo': flightNo,
      'surname': surname,
      'staffNumber': staffNumber,
      'checkInTime': checkInTime,
      'signatureIn': signatureIn,
      'checkOutTime': checkOutTime,
      'isCheckedIn': isCheckedIn,
      'signatureOut': signatureOut,
    };
  }

  // Convert a Map into a CrewScheduleEntry.
  factory CrewScheduleEntry.fromJson(Map<String, dynamic> json) {
    return CrewScheduleEntry(
      uid: json['uid'],
      flightNo: json['flightNo'],
      surname: json['surname'],
      isCheckedIn: json['isCheckedIn'],
      staffNumber: json['staffNumber'],
      checkInTime: json['checkInTime'],
      signatureIn: json['signatureIn'],
      checkOutTime: json['checkOutTime'],
      signatureOut: json['signatureOut'],
    );
  }
}
