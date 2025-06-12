import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  static String? accessToken;
  static String? refreshToken;

  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    accessToken = token;
  }

  static Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    accessToken = null;
  }
}
