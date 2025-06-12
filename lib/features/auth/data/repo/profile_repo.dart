import 'package:dartz/dartz.dart';
import 'package:ntigradproject/core/network/api_helper.dart';
import 'package:ntigradproject/core/network/api_response.dart';
import 'package:ntigradproject/core/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntigradproject/features/auth/data/model/user_model.dart';

class ProfileRepo {
  ProfileRepo._internal();
  static final ProfileRepo _instance = ProfileRepo._internal();
  factory ProfileRepo() => _instance;

  APIHelper dio = APIHelper();

  Future<Either<String, String?>> register({
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    try {
      // نرسل البيانات كـ Form-Data (مطابق لـ Postman)
      ApiResponse response = await dio.postRequest(
        endPoint: EndPoints.register,
        data: {
          "name": username,      // كما في Postman
          "password": password,
          "email": email,
          "phone": phone,
          // لو عندك صورة ترفعينها، ضعي مفتاح "image": MultipartFile.fromFile(...)
        },
        isFormData: true, // <-- مهم
        isAuthorized: false,
      );

      if (response.status) {
        return right(response.message);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left("Register Error: $e");
    }
  }

  Future<Either<String, UserModel?>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Postman: login يستخدم form-data أيضًا (email, password)
      ApiResponse response = await dio.postRequest(
        endPoint: EndPoints.login,
        data: {
          "email": email,
          "password": password,
        },
        isFormData: true, // <-- مهم
        isAuthorized: false,
      );

      if (response.status) {
        // نفترض أن الـ API يعيد بيانات المستخدم
        var user = UserModel.fromJson(response.data);
        await _saveUserData(user);
        return right(user);
      } else {
        return left(response.message);
      }
    } catch (e) {
      return left("Login Error: $e");
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', user.token);
    await prefs.setString('userData', user.toJson().toString());
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('userData');
  }
}
