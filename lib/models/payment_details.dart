class PaymentDetails {
  String paymentMethod;
  String paymentDay;
  String paymentFrequency;
  String employer;
  String commencementDate;
  String accountHolder;
  String employeeNo;
  String bankName;
  String branchCode;
  String accountNo;

  PaymentDetails({
    required this.paymentMethod,
    required this.paymentDay,
    required this.paymentFrequency,
    required this.employer,
    required this.commencementDate,
    required this.accountHolder,
    required this.employeeNo,
    required this.bankName,
    required this.branchCode,
    required this.accountNo,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentMethod: json['paymentMethod'],
      paymentDay: json['paymentDay'],
      paymentFrequency: json['paymentFrequency'],
      employer: json['employer'],
      commencementDate: json['commencementDate'],
      accountHolder: json['accountHolder'],
      employeeNo: json['employeeNo'],
      bankName: json['bankName'],
      branchCode: json['branchCode'],
      accountNo: json['accountNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': paymentMethod,
      'paymentDay': paymentDay,
      'paymentFrequency': paymentFrequency,
      'employer': employer,
      'commencementDate': commencementDate,
      'accountHolder': accountHolder,
      'employeeNo': employeeNo,
      'bankName': bankName,
      'branchCode': branchCode,
      'accountNo': accountNo,
    };
  }
}