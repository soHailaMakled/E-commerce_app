
abstract class ApiConstants { // تغيير اسم الكلاس
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String password = "password";
  static const String image = "image";
  static const String message = "message";
  static const String accessToken = "access_token"; // camelCase for consistency
  static const String refreshToken = "refresh_token"; // camelCase for consistency
  static const String status = "status";
  static const String user = "user";
  static const String id = "id";
  static const String tasks = "tasks";
  static const String createdAt = "created_at"; // camelCase for consistency
  static const String description = "description";
  static const String imagePath = "image_path"; // camelCase for consistency
  static const String title = "title";
  static const String authorization = "Authorization";
  static const String currentPassword = "current_password"; // camelCase
  static const String newPassword = "new_password"; // camelCase
  static const String newPasswordConfirm = "new_password_confirm"; // camelCase

  // Endpoints (لو عايزة تحطيهم هنا ممكن تفصليهم في كلاس تاني أو تضيفي prefix)
  static const String updateProfile = "update_profile";
  static const String addToFavorite = "add_to_favorite";
  static const String bestSeller = "best_seller_products";
  static const String topRated = "top_rated_products";
}