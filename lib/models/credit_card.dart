import 'package:flutter/material.dart';

class CreditCard {
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String creditCardType;
  double positionY = 0;
  double rotate = 0;
  double scale = 0;
  double opacity = 0;
  Color? leftColor;
  Color? rightColor;

  CreditCard({
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.creditCardType,
    this.scale = 0,
    this.opacity = 0,
    this.positionY = 0,
    this.rotate = 0,
    this.leftColor,
    this.rightColor
  });

  // Convert CreditCard object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'creditCardType': creditCardType,
    };
  }

  // Create a CreditCard object from JSON
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardHolder: json['cardHolder'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
      creditCardType: json['creditCardType'],
    );
  }
}