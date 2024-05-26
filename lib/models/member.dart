class Member {
  String surname;
  String firstNames;
  String dateOfBirth;
  String gender;
  String contactNumber;
  String email;
  String relationShip;

  Member({
    required this.relationShip,
    required this.surname,
    required this.firstNames,
    required this.dateOfBirth,
    required this.gender,
    required this.contactNumber,
    required this.email,
  });

  // Method to convert Member instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'firstNames': firstNames,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'contactNumber': contactNumber,
      'email': email,
      'relationship': relationShip
    };
  }

  // Method to create a Member instance from JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      surname: json['surname'],
      firstNames: json['firstNames'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      relationShip: json['relationship']
    );
  }
}
