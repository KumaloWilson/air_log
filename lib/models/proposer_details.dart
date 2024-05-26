import 'address.dart';

class ProposerDetails {
  String surname;
  String dateOfBirth;
  String firstName;
  String mobile;
  String email;
  String idNumber;
  String relationshipToLifeAssured;
  Address postalAddress;

  ProposerDetails({
    required this.surname,
    required this.dateOfBirth,
    required this.firstName,
    required this.mobile,
    required this.email,
    required this.idNumber,
    required this.relationshipToLifeAssured,
    required this.postalAddress,
  });

  factory ProposerDetails.fromJson(Map<String, dynamic> json) {
    return ProposerDetails(
      surname: json['surname'],
      dateOfBirth: json['dateOfBirth'],
      firstName: json['firstName'],
      mobile: json['mobile'],
      email: json['email'],
      idNumber: json['idNumber'],
      relationshipToLifeAssured: json['relationshipToLifeAssured'],
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
      'relationshipToLifeAssured': relationshipToLifeAssured,
      'postalAddress': postalAddress.toJson(),
    };
  }
}