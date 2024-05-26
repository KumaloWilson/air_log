import 'package:air_log/models/payment_details.dart';
import 'package:air_log/models/personal_details.dart';
import 'package:air_log/models/premium_payer_details.dart';
import 'package:air_log/models/proposer_details.dart';

import 'details_of_assurance.dart';

class USDLifeCareProposal {
  String clientCode;
  String policyNumber;
  PrincipalMember principalMember;
  PremiumPayerDetails premiumPayerDetails;
  ProposerDetails proposerDetails;
  PaymentDetails paymentDetails;
  DetailsOfAssurance detailsOfAssurance;

  USDLifeCareProposal({
    required this.clientCode,
    required this.policyNumber,
    required this.principalMember,
    required this.premiumPayerDetails,
    required this.proposerDetails,
    required this.paymentDetails,
    required this.detailsOfAssurance,
  });

  factory USDLifeCareProposal.fromJson(Map<String, dynamic> json) {
    return USDLifeCareProposal(
      clientCode: json['clientCode'],
      policyNumber: json['policyNumber'],
      principalMember: PrincipalMember.fromJson(json['principalMember']),
      premiumPayerDetails: PremiumPayerDetails.fromJson(json['premiumPayerDetails']),
      proposerDetails: ProposerDetails.fromJson(json['proposerDetails']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      detailsOfAssurance: DetailsOfAssurance.fromJson(json['detailsOfAssurance']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientCode': clientCode,
      'policyNumber': policyNumber,
      'principalMember': principalMember.toJson(),
      'premiumPayerDetails': premiumPayerDetails.toJson(),
      'proposerDetails': proposerDetails.toJson(),
      'paymentDetails': paymentDetails.toJson(),
      'detailsOfAssurance': detailsOfAssurance.toJson(),
    };
  }
}