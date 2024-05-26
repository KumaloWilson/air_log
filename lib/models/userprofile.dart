class UserProfile {
  late String userId;
  late String fullName;
  late String emailAddress;
  late String phoneNumber;
  late List<String> userRoles;
  late bool salesAgentVerified;
  late bool deliveryAgentVerified;
  late bool distributorVerified;
  late String dob;
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
    required this.salesAgentVerified,
    required this.deliveryAgentVerified,
    required this.distributorVerified,
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
      'sales_agent_verified': salesAgentVerified,
      'delivery_agent_verified': deliveryAgentVerified,
      'distributor_verified': distributorVerified,
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
      salesAgentVerified: json['sales_agent_verified'],
      deliveryAgentVerified: json['delivery_agent_verified'],
      distributorVerified: json['distributor_verified'],
      dob: json['dob'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}
