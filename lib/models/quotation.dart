// To parse this JSON data, do
//
//     final quotationModel = quotationModelFromMap(jsonString);

import 'dart:convert';

List<QuotationModel> quotationModelFromMap(String str) => List<QuotationModel>.from(json.decode(str).map((x) => QuotationModel.fromMap(x)));

String quotationModelToMap(List<QuotationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class QuotationModel {
  String id;
  QuotationDetails quotationDetails;
  String createdAt;
  String updatedAt;
  int v;
  Statuses statuses;

  QuotationModel({
    required this.id,
    required this.quotationDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.statuses,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> json) => QuotationModel(
    id: json["_id"],
    quotationDetails: QuotationDetails.fromMap(json["quotation-details"]),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    statuses: Statuses.fromMap(json["statuses"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "quotation-details": quotationDetails.toMap(),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "statuses": statuses.toMap(),
  };
}

class QuotationDetails {
  String patientContactInformation;
  String patientId;
  String patientName;
  String lastName;
  DateTime patientDateOfBirth;
  String patientGender;
  String patientNationalId;
  String status;
  String id;
  DateTime invoiceDate;
  String paymentReference;
  String dueDate;
  List<Product> products;
  int tax;
  int subtotal;
  double total;
  String currency;
  String generatedRef;
  String? location;
  String? doctorid;
  String currencyCode;
  String? casenumber;
  String? patientEmailAddress;
  String? expiryDate;
  double? discountTotal;
  String? accountNumber;
  String? serialNumber;
  String? invoiceType;

  QuotationDetails({
    required this.patientContactInformation,
    required this.patientId,
    required this.patientName,
    required this.lastName,
    required this.patientDateOfBirth,
    required this.patientGender,
    required this.patientNationalId,
    required this.status,
    required this.id,
    required this.invoiceDate,
    required this.paymentReference,
    required this.dueDate,
    required this.products,
    required this.tax,
    required this.subtotal,
    required this.total,
    required this.currency,
    required this.generatedRef,
    this.location,
    this.doctorid,
    required this.currencyCode,
    this.casenumber,
    this.patientEmailAddress,
    this.expiryDate,
    this.discountTotal,
    this.accountNumber,
    this.serialNumber,
    this.invoiceType,
  });

  factory QuotationDetails.fromMap(Map<String, dynamic> json) => QuotationDetails(
    patientContactInformation: json["patientContactInformation"],
    patientId: json["patientId"],
    patientName: json["patientName"],
    lastName: json["last_name"],
    patientDateOfBirth: DateTime.parse(json["patientDateOfBirth"]),
    patientGender: json["patientGender"],
    patientNationalId: json["patientNationalId"],
    status: json["status"],
    id: json["id"],
    invoiceDate: DateTime.parse(json["invoiceDate"]),
    paymentReference: json["paymentReference"],
    dueDate: json["dueDate"],
    products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    tax: json["tax"],
    subtotal: json["subtotal"],
    total: json["total"]?.toDouble(),
    currency: json["currency"],
    generatedRef: json["generatedRef"],
    location: json["location"],
    doctorid: json["doctorid"],
    currencyCode: json["currencyCode"],
    casenumber: json["casenumber"],
    patientEmailAddress: json["patientEmailAddress"],
    expiryDate: json["expiryDate"],
    discountTotal: json["discountTotal"]?.toDouble(),
    accountNumber: json["accountNumber"],
    serialNumber: json["serialNumber"],
    invoiceType: json["invoiceType"],
  );

  Map<String, dynamic> toMap() => {
    "patientContactInformation": patientContactInformation,
    "patientId": patientId,
    "patientName": patientName,
    "last_name": lastName,
    "patientDateOfBirth": "${patientDateOfBirth.year.toString().padLeft(4, '0')}-${patientDateOfBirth.month.toString().padLeft(2, '0')}-${patientDateOfBirth.day.toString().padLeft(2, '0')}",
    "patientGender": patientGender,
    "patientNationalId": patientNationalId,
    "status": status,
    "id": id,
    "invoiceDate": "${invoiceDate.year.toString().padLeft(4, '0')}-${invoiceDate.month.toString().padLeft(2, '0')}-${invoiceDate.day.toString().padLeft(2, '0')}",
    "paymentReference": paymentReference,
    "dueDate": dueDate,
    "products": List<dynamic>.from(products.map((x) => x.toMap())),
    "tax": tax,
    "subtotal": subtotal,
    "total": total,
    "currency": currency,
    "generatedRef": generatedRef,
    "location": location,
    "doctorid": doctorid,
    "currencyCode": currencyCode,
    "casenumber": casenumber,
    "patientEmailAddress": patientEmailAddress,
    "expiryDate": expiryDate,
    "discountTotal": discountTotal,
    "accountNumber": accountNumber,
    "serialNumber": serialNumber,
    "invoiceType": invoiceType,
  };
}

class Product {
  String name;
  int price;
  int tax;
  int quantity;
  int discount;

  Product({
    required this.name,
    required this.price,
    required this.tax,
    required this.quantity,
    required this.discount,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    name: json["name"],
    price: json["price"],
    tax: json["tax"],
    quantity: json["quantity"],
    discount: json["discount"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "price": price,
    "tax": tax,
    "quantity": quantity,
    "discount": discount,
  };
}

class Statuses {
  String? comment;
  String? selectedReason;
  String? status;

  Statuses({
    this.comment,
    this.selectedReason,
    this.status,
  });

  factory Statuses.fromMap(Map<String, dynamic> json) => Statuses(
    comment: json["comment"],
    selectedReason: json["selectedReason"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "comment": comment,
    "selectedReason": selectedReason,
    "status": status,
  };
}
