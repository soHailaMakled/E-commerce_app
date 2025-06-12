
import 'package:ntigradproject/core/network/api_base_url.dart';

abstract class ApiEndpoint {
  // استخدام الـ baseUrl من ApiBaseUrl لضمان التناسق
  static const String _baseUrl = ApiBaseUrl.baseUrl;

  // Endpoints لعمليات الـ Authentication
  static const String register = "${_baseUrl}register";
  static const String login = "${_baseUrl}login";
  static const String refreshToken = "${_baseUrl}refresh_token";
  static const String changePassword = "${_baseUrl}change_password";
  static const String updateProfile = "${_baseUrl}update_profile";
  static const String getUserData = "${_baseUrl}get_user_data";

  // Endpoints للمنتجات والتصنيفات
  static const String categories = "${_baseUrl}categories";
  static const String bestSeller = "${_baseUrl}best_seller_products";
  static const String topRated = "${_baseUrl}top_rated_products";
  static const String addToFavorite = "${_baseUrl}add_to_favorite";

  // Endpoints خاصة بسلة التسوق وإتمام الطلب
  static const String checkout = "${_baseUrl}checkout";

  // Endpoints خاصة بالمهام (لو التطبيق يحتوي على جزء خاص بالمهام بجانب الـ E-commerce)
  static const String tasks = "${_baseUrl}tasks";
  static const String myTasks = "${_baseUrl}my_tasks";
  static const String newTasks = "${_baseUrl}new_task";
}
