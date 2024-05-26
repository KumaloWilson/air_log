import 'package:air_log/models/payment_details.dart';
import 'package:air_log/models/personal_details.dart';
import 'package:air_log/models/premium_payer_details.dart';
import 'member.dart';

class FuneralCashPlan {
  String clientCode;
  String policyNumber;
  String currency;
  PrincipalMember principalMember;
  PremiumPayerDetails premiumPayerDetails;
  PaymentDetails paymentDetails;
  List<Member> members;

  FuneralCashPlan({
    required this.clientCode,
    required this.policyNumber,
    required this.currency,
    required this.principalMember,
    required this.premiumPayerDetails,
    required this.paymentDetails,
    required this.members,
  });

  // Method to convert FuneralCashPlanForm instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'clientCode': clientCode,
      'policyNumber': policyNumber,
      'currency': currency,
      'premiumPayerDetails': premiumPayerDetails.toJson(),
      'principalMember': principalMember.toJson(),
      'paymentDetails': paymentDetails.toJson(),
      'members': members.map((member) => member.toJson()).toList(),
    };
  }

  // Method to create a FuneralCashPlanForm instance from JSON
  factory FuneralCashPlan.fromJson(Map<String, dynamic> json) {
    return FuneralCashPlan(
      clientCode: json['clientCode'],
      policyNumber: json['policyNumber'],
      currency: json['currency'],
      principalMember: PrincipalMember.fromJson(json['principalMember']),
      premiumPayerDetails: PremiumPayerDetails.fromJson(json['premiumPayerDetails']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      members: List<Member>.from(json['members'].map((item) => Member.fromJson(item))),
    );
  }
}
