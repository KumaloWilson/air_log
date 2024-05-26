import 'address.dart';

class PremiumPayerDetails {
  String surname;
  String dateOfBirth;
  String firstName;
  String mobile;
  String email;
  String idNumber;
  Address postalAddress;

  PremiumPayerDetails({
  required this.surname,
  required this.dateOfBirth,
  required this.firstName,
    required this.mobile,
    required this.email,
    required this.idNumber,
    required this.postalAddress,
  });

  factory PremiumPayerDetails.fromJson(Map<String, dynamic> json) {
    return PremiumPayerDetails(
      surname: json['surname'],
      dateOfBirth: json['dateOfBirth'],
      firstName: json['firstName'],
      mobile: json['mobile'],
      email: json['email'],
      idNumber: json['idNumber'],
      postalAddress: Address.fromJson(json['postalAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'dateOfBirth': dateOfBirth,
      'firstName': firstName,
      'mobile': mobile,
      'email': email,
      'idNumber': idNumber,
      'postalAddress': postalAddress.toJson(),
    };
  }
}