import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String responseDataKey = 'responseData';

  static Future<bool> saveToken(Map<String, dynamic> responseData) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(responseDataKey, json.encode(responseData));
  }

  static Future<Map<String, dynamic>?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final responseDataString = prefs.getString(responseDataKey);
    if (responseDataString == null) {
      return null;
    }
    return json.decode(responseDataString);
  }

  static Future clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    final responseDataString = prefs.getString(responseDataKey);
  }

}
