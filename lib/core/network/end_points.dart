abstract class ApiBaseUrl {
  static const String baseUrl =
      "https://nti-ecommerce-api-production.up.railway.app/api/";
}

abstract class ApiEndpoint {
  static const String baseUrl = ApiBaseUrl.baseUrl;

  static const String register = "${baseUrl}register";
  static const String login = "${baseUrl}login";
  static const String tasks = "${baseUrl}tasks";
  static const String mytasks = "${baseUrl}my_tasks";
  static const String newTasks = "${baseUrl}new_task";
  static const String refreshtoken = "${baseUrl}refresh_token";
  static const String changePassword = "${baseUrl}change_password";
  static const String updateprofile = "${baseUrl}update_profile";
  static const String getuserdata = "${baseUrl}get_user_data";
  static const String getcatogory = "${baseUrl}categories";
  static const String checkout = "${baseUrl}checkout";
}

abstract class EndPoints {
  static const String register = ApiEndpoint.register;
  static const String login = ApiEndpoint.login;
  static const String checkout = ApiEndpoint.checkout;
}
