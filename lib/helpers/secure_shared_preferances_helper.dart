import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/credit_card.dart'; // assuming you're still using Fluttertoast for displaying toasts

class SecureSharedPreferenceHelper {
  static AndroidOptions getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  static final _storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  static const _creditCardsKey = 'creditCards';

  static Future<void> saveCreditCardData(List<CreditCard> creditCards, String successMessage) async {
    final value = jsonEncode(creditCards.map((card) => card.toJson()).toList());
    await _storage.write(key: _creditCardsKey, value: value);

    Fluttertoast.showToast(msg: successMessage);
  }

  static Future<List<CreditCard>> getCreditCardData() async {
    final value = await _storage.read(key: _creditCardsKey);
    if (value != null) {
      final List<dynamic> jsonList = jsonDecode(value);
      return jsonList.map((json) => CreditCard.fromJson(json)).toList();
    }
    return [];
  }

  // method to delete a credit card by its number
  static Future<void> deleteCreditCardByNumber(String cardNumber) async {
    try {
      final List<CreditCard> creditCards = await getCreditCardData();
      final updatedCreditCards = creditCards.where((card) => card.cardNumber != cardNumber).toList();
      await saveCreditCardData(updatedCreditCards, 'Card Deleted Successfully');
    } catch (e) {
      print('Error deleting credit card: $e');
      // Handle error gracefully, perhaps by showing a toast or logging.
    }
  }
}
