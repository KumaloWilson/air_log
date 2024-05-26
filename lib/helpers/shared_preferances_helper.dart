import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global.dart';
import '../main.dart';
import '../models/userprofile.dart';

class SharedPreferencesHelper {
  static const String _userRoleKey = 'userRole';
  static const String _cartKey = 'cart_items';
  //static const String _creditCardsKey = 'credit_cards';


  static Future<void> cacheUserRole({required UserRole role}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userRoleKey, role.toString().split('.').last);
    } catch (e) {
      print('Error caching user role: $e');
      // Handle error gracefully, perhaps by showing a toast or logging.
    }
  }

  static Future<void> getSelectedUserRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedRole = prefs.getString(_userRoleKey);
      if (cachedRole != null) {
        final cachedUserRole = UserRole.values.firstWhere((role) => role.toString().split('.').last == cachedRole);
        userRole = cachedUserRole;
        print('============CACHED USERROLE $cachedUserRole=============');
        return;
      }
      print('Cached user role not found or invalid.');
      // Handle missing or invalid cached role.
    } catch (e) {
      print('Error navigating to cached user role: $e');
    }
  }

  static Future<void> clearCachedUserRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userRoleKey);
      userRole = null;
      await getSelectedUserRole();
    } catch (e) {
      print('Error clearing cached user role: $e');
      // Handle error gracefully, perhaps by showing a toast or logging.
    }
  }

  static Future<void> checkOnBoardingStatus() async {

    final key = 'hasSeen${userRole.toString().split('.').last}Onboarding';
    final prefs = await SharedPreferences.getInstance();
    hasSeenOnboarding = prefs.getBool(key) ?? false;
  }

  static Future<void> updateOnboardingStatus(bool status) async {
    hasSeenOnboarding = status;

    final key = 'hasSeen${userRole.toString().split('.').last}Onboarding';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, status);
    await checkOnBoardingStatus();
  }


  static Future<void> checkIsStartedStatus() async {
    const String key = 'isStarted';
    final prefs = await SharedPreferences.getInstance();
    isStarted = prefs.getBool(key) ?? false;
  }

  static Future<void> updateIsStartedStatus(bool status) async {
    isStarted = status;

    const String key = 'isStarted';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, status);
    await checkIsStartedStatus();
  }

  static Future<void> saveUserProfileToCache(UserProfile userProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', jsonEncode(userProfile.toJson()));
  }

  static Future<UserProfile?> getUserProfileInformationFromCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userProfileString = prefs.getString('userProfile');

    if (userProfileString != null) {
      final userProfileJson = jsonDecode(userProfileString);

      return UserProfile.fromJson(userProfileJson);
    } else {
      return null;
    }
  }

}