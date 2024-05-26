import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/userprofile.dart';

class UserProfileServices{
  static Future<String> saveUserDetailsToFirestore({
    required String userId,
    required String fullName,
    required String emailAddress,
    required String phoneNumber,
    required List<String> userRoles,
    required String dob,
    required String staffNumber,
    required String address,
    required String city,
    required String state,
    required String country,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Define the document path
      final DocumentReference userDocRef = firestore.collection('users').doc(userId);

      // Define the user data to be saved
      final Map<String, dynamic> userData = {
        'user_id': userId,
        'full_name': fullName,
        'email_address': emailAddress,
        'phone_number': phoneNumber,
        'user_roles': userRoles,
        'staff_number': staffNumber,
        'sales_agent_verified': false,
        'delivery_agent_verified': false,
        'distributor_verified': false,
        'dob': dob,
        'active' : false,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
      };

      // Save the user data to Firestore
      await userDocRef.set(userData);

      return 'success';

    } catch (e) {
      // Handle specific errors
      if (e is FirebaseException) {
        // Firebase-related errors
        String errorMessage = 'Error saving user details to Firestore: ${e.message}';
        return errorMessage;
      } else {
        // Other unexpected errors
        String errorMessage = 'Unexpected error: $e';
        return errorMessage;
      }
    }
  }


  static Future<UserProfile?> fetchUserProfileInformation(String userId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot userDoc =  await firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return UserProfile.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null; // User does not exist
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null; // Handle error appropriately
    }
  }

  static Future<String> updatePhoneNumber(String userId, String phoneNumber) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userDocRef = firestore.collection('users').doc(userId);

      await userDocRef.update({'phone_number': phoneNumber});

      return 'Phone number updated successfully';
    } catch (e) {
      print('Error updating phone number: $e');
      return 'Failed to update phone number';
    }
  }

  static Future<String> updateAddress(String userId, String address) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userDocRef = firestore.collection('users').doc(userId);

      await userDocRef.update({'address': address});

      return 'Address updated successfully';
    } catch (e) {
      print('Error updating address: $e');
      return 'Failed to update address';
    }
  }


  static Future<String> updateCityStateCountry(String userId, String city, String state, String country) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userDocRef = firestore.collection('users').doc(userId);

      await userDocRef.update({
        'city': city,
        'state': state,
        'country': country
      });

      return 'Address updated successfully';
    } catch (e) {
      print('Error updating address: $e');
      return 'Failed to update address';
    }
  }


  static Future<String> updateUserRoles(String userId, List<String> userRoles) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentReference userDocRef = firestore.collection('users').doc(userId);

      await userDocRef.update({'user_roles': userRoles});

      return 'User roles updated successfully';
    } catch (e) {
      print('Error updating user roles: $e');
      return 'Failed to update user roles';
    }
  }
}