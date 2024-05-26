// To parse this JSON data, do
//
//     final claimsModel = claimsModelFromMap(jsonString);

import 'dart:convert';

List<ClaimsModel> claimsModelFromMap(String str) => List<ClaimsModel>.from(json.decode(str).map((x) => ClaimsModel.fromMap(x)));

String claimsModelToMap(List<ClaimsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ClaimsModel {
  String id;
  ClaimantDetails claimantDetails;
  ClaimDetails claimDetails;
  List<Document> documents;
  String createdAt;
  String updatedAt;
  int v;

  ClaimsModel({
    required this.id,
    required this.claimantDetails,
    required this.claimDetails,
    required this.documents,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ClaimsModel.fromMap(Map<String, dynamic> json) => ClaimsModel(
    id: json["_id"],
    claimantDetails: ClaimantDetails.fromMap(json["claimantDetails"]),
    claimDetails: ClaimDetails.fromMap(json["claimDetails"]),
    documents: List<Document>.from(json["documents"].map((x) => Document.fromMap(x))),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "claimantDetails": claimantDetails.toMap(),
    "claimDetails": claimDetails.toMap(),
    "documents": List<dynamic>.from(documents.map((x) => x.toMap())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class ClaimDetails {
  HospitalizationDetails hospitalizationDetails;
  int claimedAmount;
  String hasOtherHealthInsurance;
  String claimStatus;

  ClaimDetails({
    required this.hospitalizationDetails,
    required this.claimedAmount,
    required this.hasOtherHealthInsurance,
    required this.claimStatus,
  });

  factory ClaimDetails.fromMap(Map<String, dynamic> json) => ClaimDetails(
    hospitalizationDetails: HospitalizationDetails.fromMap(json["hospitalizationDetails"]),
    claimedAmount: json["claimedAmount"],
    hasOtherHealthInsurance: json["hasOtherHealthInsurance"],
    claimStatus: json["claimStatus"],
  );

  Map<String, dynamic> toMap() => {
    "hospitalizationDetails": hospitalizationDetails.toMap(),
    "claimedAmount": claimedAmount,
    "hasOtherHealthInsurance": hasOtherHealthInsurance,
    "claimStatus": claimStatus,
  };
}

class HospitalizationDetails {
  String hospitalName;
  DateTime admissionDate;
  String doctorName;
  int doctorPhoneNumber;
  String? hospitalizationReason;
  DateTime? dateOfDischarge;

  HospitalizationDetails({
    required this.hospitalName,
    required this.admissionDate,
    required this.doctorName,
    required this.doctorPhoneNumber,
    this.hospitalizationReason,
    this.dateOfDischarge,
  });

  factory HospitalizationDetails.fromMap(Map<String, dynamic> json) => HospitalizationDetails(
    hospitalName: json["hospitalName"],
    admissionDate: DateTime.parse(json["admissionDate"]),
    doctorName: json["doctorName"],
    doctorPhoneNumber: json["doctorPhoneNumber"],
    hospitalizationReason: json["hospitalizationReason"],
    dateOfDischarge: json["dateOfDischarge"] == null ? null : DateTime.parse(json["dateOfDischarge"]),
  );

  Map<String, dynamic> toMap() => {
    "hospitalName": hospitalName,
    "admissionDate": "${admissionDate.year.toString().padLeft(4, '0')}-${admissionDate.month.toString().padLeft(2, '0')}-${admissionDate.day.toString().padLeft(2, '0')}",
    "doctorName": doctorName,
    "doctorPhoneNumber": doctorPhoneNumber,
    "hospitalizationReason": hospitalizationReason,
    "dateOfDischarge": "${dateOfDischarge!.year.toString().padLeft(4, '0')}-${dateOfDischarge!.month.toString().padLeft(2, '0')}-${dateOfDischarge!.day.toString().padLeft(2, '0')}",
  };
}

class ClaimantDetails {
  String policyNumber;
  String patientId;
  DateTime dateOfBirth;
  String gender;
  String lastName;
  String identificationType;
  String firstName;
  String nationalId;
  String phoneNumber;
  String email;
  String streetAddress;
  String city;
  String country;
  String zipCode;
  String patientImage;

  ClaimantDetails({
    required this.policyNumber,
    required this.patientId,
    required this.dateOfBirth,
    required this.gender,
    required this.lastName,
    required this.identificationType,
    required this.firstName,
    required this.nationalId,
    required this.phoneNumber,
    required this.email,
    required this.streetAddress,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.patientImage,
  });

  factory ClaimantDetails.fromMap(Map<String, dynamic> json) => ClaimantDetails(
    policyNumber: json["policyNumber"],
    patientId: json["patientId"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    lastName: json["lastName"],
    identificationType: json["identificationType"],
    firstName: json["firstName"],
    nationalId: json["nationalID"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    streetAddress: json["streetAddress"],
    city: json["city"],
    country: json["country"],
    zipCode: json["zipCode"],
    patientImage: json["patientImage"],
  );

  Map<String, dynamic> toMap() => {
    "policyNumber": policyNumber,
    "patientId": patientId,
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "lastName": lastName,
    "identificationType": identificationType,
    "firstName": firstName,
    "nationalID": nationalId,
    "phoneNumber": phoneNumber,
    "email": email,
    "streetAddress": streetAddress,
    "city": city,
    "country": country,
    "zipCode": zipCode,
    "patientImage": patientImage,
  };
}

class Document {
  String documentId;
  String documentName;
  String status;
  String documentType;
  String documentPath;
  String? documentCriteria;

  Document({
    required this.documentId,
    required this.documentName,
    required this.status,
    required this.documentType,
    required this.documentPath,
    this.documentCriteria,
  });

  factory Document.fromMap(Map<String, dynamic> json) => Document(
    documentId: json["document_id"],
    documentName: json["document_name"],
    status: json["status"],
    documentType: json["document_type"],
    documentPath: json["document_path"],
    documentCriteria: json["documentCriteria"],
  );

  Map<String, dynamic> toMap() => {
    "document_id": documentId,
    "document_name": documentName,
    "status": status,
    "document_type": documentType,
    "document_path": documentPath,
    "documentCriteria": documentCriteria,
  };
}
