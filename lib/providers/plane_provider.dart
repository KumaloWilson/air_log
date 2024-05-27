import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaneProvider with ChangeNotifier {
  String _planeNumber = '';
  String _planeType = '';

  String get planeNumber => _planeNumber;
  String get planeType => _planeType;

  PlaneProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _planeNumber = prefs.getString('planeNumber') ?? '';
    _planeType = prefs.getString('planeType') ?? '';
    notifyListeners();
  }

  Future<void> setPlane(String number, String type) async {
    _planeNumber = number;
    _planeType = type;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('planeNumber', number);
    await prefs.setString('planeType', type);
  }
}
