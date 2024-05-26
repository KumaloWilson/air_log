class UserProfile {
  late String userId;
  late String fullName;
  late String? displayImage;
  late String emailAddress;
  late String phoneNumber;
  late List<String> userRoles;
  late bool isAccountActive;
  late String dob;
  late String staffNumber;
  late String address;
  late String city;
  late String state;
  late String country;

  UserProfile({
    required this.userId,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.userRoles,
    this.displayImage,
    required this.staffNumber,
    required this.isAccountActive,
    required this.dob,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email_address': emailAddress,
      'phone_number': phoneNumber,
      'user_roles': userRoles,
      'display_image': displayImage,
      'active': isAccountActive,
      'staff_number': staffNumber,
      'dob': dob,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      fullName: json['full_name'],
      emailAddress: json['email_address'],
      phoneNumber: json['phone_number'],
      userRoles: List<String>.from(json['user_roles']),
      isAccountActive: json['active'],
      staffNumber: json['staff_number'],
      dob: json['dob'],
      displayImage: json['display_image'] ?? '',
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}
