import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // لإضافة debugPrint في وضع الـ Debug
import 'dart:convert'; // لإضافة jsonEncode و jsonDecode
import 'package:ntigradproject/features/auth/data/model/user_model.dart'; // لاستخدام UserModel

abstract class LocalData {
  static String? accessToken;
  static String? refreshToken;
  static UserModel? currentUser; // لإضافة متغير لتخزين بيانات المستخدم الحالية

  // مفتاح تخزين الـ access token في SharedPreferences
  static const String _accessTokenKey = 'accessToken';
  // مفتاح تخزين الـ refresh token في SharedPreferences
  static const String _refreshTokenKey = 'refreshToken';
  // مفتاح تخزين بيانات المستخدم في SharedPreferences
  static const String _userDataKey = 'userData';

  // ميثود لحفظ كلا الـ tokens (Access و Refresh)
  static Future<void> saveAuthTokens({
    required String newAccessToken,
    required String newRefreshToken,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_accessTokenKey, newAccessToken);
      await prefs.setString(_refreshTokenKey, newRefreshToken);
      accessToken = newAccessToken;
      refreshToken = newRefreshToken;
      if (kDebugMode) {
        debugPrint('Auth tokens saved successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error saving auth tokens: $e');
      }
      // ممكن نضيف هنا معالجة أخطاء أفضل أو تسجيل الخطأ
    }
  }

  // ميثود لحفظ بيانات المستخدم (UserModel)
  static Future<void> saveUserData(UserModel user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // تحويل كائن UserModel إلى JSON String وحفظه
      await prefs.setString(_userDataKey, jsonEncode(user.toJson()));
      currentUser = user;
      if (kDebugMode) {
        debugPrint('User data saved successfully: ${user.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error saving user data: $e');
      }
    }
  }

  // ميثود لتحميل كلا الـ tokens (Access و Refresh)
  static Future<void> loadAuthTokens() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString(_accessTokenKey);
      refreshToken = prefs.getString(_refreshTokenKey);
      if (kDebugMode) {
        debugPrint('Auth tokens loaded. AccessToken: $accessToken, RefreshToken: $refreshToken');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading auth tokens: $e');
      }
    }
  }

  // ميثود لتحميل بيانات المستخدم (UserModel)
  static Future<void> loadUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userDataJson = prefs.getString(_userDataKey);
      if (userDataJson != null && userDataJson.isNotEmpty) {
        // تحويل JSON String إلى Map ثم إلى UserModel
        currentUser = UserModel.fromJson(jsonDecode(userDataJson));
        if (kDebugMode) {
          debugPrint('User data loaded successfully: ${currentUser?.name}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading user data: $e');
      }
    }
  }

  // ميثود لمسح كلا الـ tokens وبيانات المستخدم
  static Future<void> clearAuthTokens() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_refreshTokenKey);
      await prefs.remove(_userDataKey); // مسح بيانات المستخدم أيضاً
      accessToken = null;
      refreshToken = null;
      currentUser = null; // مسح كائن المستخدم الحالي
      if (kDebugMode) {
        debugPrint('Auth tokens and user data cleared successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error clearing auth tokens: $e');
      }
    }
  }
}
