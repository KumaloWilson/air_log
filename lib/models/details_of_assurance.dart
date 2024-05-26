class DetailsOfAssurance {
  double basicCoverSumAssured;
  double basicCoverPremium;
  double accidentalDeathBenefitSumAssured;
  double accidentalDeathBenefitPremium;
  double funeralBenefitSumAssured;
  double funeralBenefitPremium;
  double occupationalLoadingSumAssured;
  double occupationalLoadingPremium;
  double healthLoadingSumAssured;
  double healthLoadingPremium;
  double totalPremium;

  DetailsOfAssurance({
    required this.basicCoverSumAssured,
    required this.basicCoverPremium,
    required this.accidentalDeathBenefitSumAssured,
    required this.accidentalDeathBenefitPremium,
    required this.funeralBenefitSumAssured,
    required this.funeralBenefitPremium,
    required this.occupationalLoadingSumAssured,
    required this.occupationalLoadingPremium,
    required this.healthLoadingSumAssured,
    required this.healthLoadingPremium,
    required this.totalPremium,
  });

  factory DetailsOfAssurance.fromJson(Map<String, dynamic> json) {
    return DetailsOfAssurance(
      basicCoverSumAssured: json['basicCoverSumAssured'],
      basicCoverPremium: json['basicCoverPremium'],
      accidentalDeathBenefitSumAssured: json['accidentalDeathBenefitSumAssured'],
      accidentalDeathBenefitPremium: json['accidentalDeathBenefitPremium'],
      funeralBenefitSumAssured: json['funeralBenefitSumAssured'],
      funeralBenefitPremium: json['funeralBenefitPremium'],
      occupationalLoadingSumAssured: json['occupationalLoadingSumAssured'],
      occupationalLoadingPremium: json['occupationalLoadingPremium'],
      healthLoadingSumAssured: json['healthLoadingSumAssured'],
      healthLoadingPremium: json['healthLoadingPremium'],
      totalPremium: json['totalPremium'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basicCoverSumAssured': basicCoverSumAssured,
      'basicCoverPremium': basicCoverPremium,
      'accidentalDeathBenefitSumAssured': accidentalDeathBenefitSumAssured,
      'accidentalDeathBenefitPremium': accidentalDeathBenefitPremium,
      'funeralBenefitSumAssured': funeralBenefitSumAssured,
      'funeralBenefitPremium': funeralBenefitPremium,
      'occupationalLoadingSumAssured': occupationalLoadingSumAssured,
      'occupationalLoadingPremium': occupationalLoadingPremium,
      'healthLoadingSumAssured': healthLoadingSumAssured,
      'healthLoadingPremium': healthLoadingPremium,
      'totalPremium': totalPremium,
    };
  }
}