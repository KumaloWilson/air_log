import 'address.dart';

class PrincipalMember {
  String surname;
  String maidenName;
  String title;
  String firstName;
  String dateOfBirth;
  String idNumber;
  String gender;
  String nationality;
  String maritalStatus;
  String occupation;
  String annualIncome;
  String mobile;
  String industry;
  String email;
  bool receiveCommunication;
  String preferredNotificationMethod;
  String preferredPostalMethod;
  Address postalAddress;

  PrincipalMember({
    required this.surname,
    required this.maidenName,
    required this.title,
    required this.firstName,
    required this.dateOfBirth,
    required this.idNumber,
    required this.gender,
    required this.nationality,
    required this.maritalStatus,
    required this.occupation,
    required this.annualIncome,
    required this.mobile,
    required this.industry,
    required this.email,
    required this.receiveCommunication,
    required this.preferredNotificationMethod,
    required this.preferredPostalMethod,
    required this.postalAddress,
  });

  factory PrincipalMember.fromJson(Map<String, dynamic> json) {
    return PrincipalMember(
      surname: json['surname'],
      maidenName: json['maidenName'],
      title: json['title'],
      firstName: json['firstName'],
      dateOfBirth: json['dateOfBirth'],
      idNumber: json['idNumber'],
      gender: json['gender'],
      nationality: json['nationality'],
      maritalStatus: json['maritalStatus'],
      occupation: json['occupation'],
      annualIncome: json['annualIncome'],
      mobile: json['mobile'],
      industry: json['industry'],
      email: json['email'],
      receiveCommunication: json['receiveCommunication'],
      preferredNotificationMethod: json['preferredNotificationMethod'],
      preferredPostalMethod: json['preferredPostalMethod'],
      postalAddress: Address.fromJson(json['postalAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'maidenName': maidenName,
      'title': title,
      'firstName': firstName,
      'dateOfBirth': dateOfBirth,
      'idNumber': idNumber,
      'gender': gender,
      'nationality': nationality,
      'maritalStatus': maritalStatus,
      'occupation': occupation,
      'annualIncome': annualIncome,
      'mobile': mobile,
      'industry': industry,
      'email': email,
      'receiveCommunication': receiveCommunication,
      'preferredNotificationMethod': preferredNotificationMethod,
      'preferredPostalMethod': preferredPostalMethod,
      'postalAddress': postalAddress.toJson(),
    };
  }
}