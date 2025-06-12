import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntigradproject/features/auth/data/model/user_model.dart';
import 'package:ntigradproject/features/auth/manager/login_cubit/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInit());
  static LoginCubit get(context) => BlocProvider.of(context);

  final Dio _dio = Dio(BaseOptions(baseUrl: "https://yourapi.com/api")); // عدلي عنوان الـ API حسب الحاجة

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await _dio.post(
        "/login",
        data: {"email": email, "password": password},
      );

      print("API Response: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        final userData = UserModel.fromJson(response.data);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', userData.token);
        await prefs.setString('username', userData.name.isNotEmpty ? userData.name : "غير متوفر");
        await prefs.setString('email', userData.email.isNotEmpty ? userData.email : "غير متوفر");
        // إذا كان هناك حقل الهاتف في بيانات المستخدم، حدديه، وإلا استخدمي قيمة افتراضية
        await prefs.setString('phone', "غير متوفر");

        emit(LoginSuccess(userData));
      } else {
        emit(LoginError("فشل تسجيل الدخول"));
      }
    } catch (e) {
      emit(LoginError("خطأ أثناء تسجيل الدخول: ${e.toString()}"));
    }
  }
}
