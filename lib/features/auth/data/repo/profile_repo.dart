import 'package:dartz/dartz.dart'; // لتسهيل التعامل مع النجاح أو الفشل
import 'package:ntigradproject/core/network/api_helper.dart'; // ✅ هذا هو الـ import الصحيح لـ APIHelper
import 'package:ntigradproject/core/network/api_response.dart';
import 'package:ntigradproject/core/local/local_data.dart'; // import لـ LocalData
import 'package:ntigradproject/features/auth/data/model/user_model.dart';
import 'package:ntigradproject/core/network/api_endpoint.dart'; // ✅ هذا هو الـ import الصحيح لـ ApiEndpoint
import 'package:ntigradproject/core/models/data/login_response_model.dart'; // import لـ LoginResponseModel
import 'package:dio/dio.dart'; // لإدارة أخطاء Dio

class ProfileRepo {
  // Singleton Pattern: بنضمن وجود instance واحدة بس من ProfileRepo
  ProfileRepo._internal();
  static final ProfileRepo _instance = ProfileRepo._internal();
  factory ProfileRepo() => _instance;

  final APIHelper _apiHelper = APIHelper(); // استخدام الـ APIHelper اللي ظبطناه

  // دالة التسجيل (Register)
  Future<Either<String, String?>> register({
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    try {
      // نرسل البيانات كـ Form-Data (مطابق لـ Postman)
      ApiResponse response = await _apiHelper.post( // استخدام _apiHelper.post
        ApiEndpoint.register, // استخدام ApiEndpoint.register
        data: {
          "name": username,      // كما في Postman
          "password": password,
          "email": email,
          "phone": phone,
          // لو عندك صورة ترفعينها، ضعي مفتاح "image": MultipartFile.fromFile(...)
        },
        isFormData: true, // <-- مهم
      );

      if (response.status) {
        return right(response.message); // ✅ تم إزالة ?? "..."
      } else {
        return left(response.message); // ✅ تم إزالة ?? "..."
      }
    } on DioException catch (e) {
      // معالجة أخطاء Dio بشكل خاص
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      // معالجة أي أخطاء أخرى غير متوقعة
      return left("حدث خطأ غير متوقع أثناء التسجيل: ${e.toString()}");
    }
  }

  // دالة تسجيل الدخول (Login)
  Future<Either<String, UserModel?>> login({
    required String email,
    required String password,
  }) async {
    try {
      // استخدام _apiHelper.login اللي عدلناها للتعامل مع الـ username/email
      ApiResponse response = await _apiHelper.login(
        username: email, // ممكن يكون ده الـ email أو الـ username حسب الـ API
        password: password,
      );

      if (response.status) {
        // تحويل الـ response.data إلى LoginResponseModel
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(response.data);

        // حفظ بيانات الـ tokens باستخدام LocalData.saveAuthTokens
        await LocalData.saveAuthTokens(
          newAccessToken: loginResponse.accessToken,
          newRefreshToken: loginResponse.refreshToken,
        );

        // ✅ حفظ بيانات المستخدم (user model) في LocalData مباشرةً لأن loginResponse.user مضمون أنه ليس null
        await LocalData.saveUserData(loginResponse.user);

        return right(loginResponse.user); // إرجاع الـ UserModel
      } else {
        return left(response.message); // ✅ تم إزالة ?? "..."
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("حدث خطأ غير متوقع أثناء تسجيل الدخول: ${e.toString()}");
    }
  }

  // دالة تسجيل الخروج (Logout)
  Future<void> logout() async {
    // استخدام LocalData.clearAuthTokens لمسح كلا الـ tokens وبيانات المستخدم
    await LocalData.clearAuthTokens();
    // هنا ممكن تضيفي أي استدعاء API لـ logout على الـ Backend لو موجود
    // try {
    //   await _apiHelper.post(ApiEndpoint.logout, data: {});
    // } catch (e) {
    //   // معالجة الخطأ ولكن لا تمنعي الـ logout المحلي
    //   debugPrint("Error calling logout API: $e"); // استخدام debugPrint
    // }
  }

  // مثال لدالة جلب بيانات المستخدم بعد تسجيل الدخول
  Future<Either<String, UserModel?>> getUserProfile() async {
    try {
      // هنا الـ token بيتم إضافته تلقائياً عن طريق الـ Interceptor في Dio
      ApiResponse response = await _apiHelper.get(ApiEndpoint.getUserData);

      if (response.status) {
        // نفترض أن الـ API يعيد بيانات المستخدم مباشرة
        UserModel user = UserModel.fromJson(response.data);
        // تحديث بيانات المستخدم في LocalData بعد جلبها
        await LocalData.saveUserData(user);
        return right(user);
      } else {
        return left(response.message); // ✅ تم إزالة ?? "..."
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("حدث خطأ غير متوقع أثناء جلب بيانات المستخدم: ${e.toString()}");
    }
  }

  // مثال لدالة لتغيير كلمة المرور
  Future<Either<String, String?>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      ApiResponse response = await _apiHelper.post(
        ApiEndpoint.changePassword,
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirm": newPasswordConfirm,
        },
        isFormData: true, // أو false حسب الـ API
      );

      if (response.status) {
        return right(response.message ?? "تم تغيير كلمة المرور بنجاح."); // ✅ تم إزالة ?? "..." (إذا كان الـ API يرجع رسالة)
      } else {
        return left(response.message ?? "فشل تغيير كلمة المرور."); // ✅ تم إزالة ?? "..." (إذا كان الـ API يرجع رسالة)
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("حدث خطأ غير متوقع أثناء تغيير كلمة المرور: ${e.toString()}");
    }
  }

  // دالة تحديث الملف الشخصي
  Future<Either<String, UserModel?>> updateProfile({
    String? name,
    String? email,
    String? phone,
    // Add other fields as needed
  }) async {
    try {
      Map<String, dynamic> requestData = {};
      if (name != null) requestData["name"] = name;
      if (email != null) requestData["email"] = email;
      if (phone != null) requestData["phone"] = phone;

      ApiResponse response = await _apiHelper.post( // أو put حسب الـ API
        ApiEndpoint.updateProfile,
        data: requestData,
        isFormData: true, // أو false حسب الـ API
      );

      if (response.status) {
        UserModel updatedUser = UserModel.fromJson(response.data);
        // تحديث بيانات المستخدم في LocalData بعد التحديث
        await LocalData.saveUserData(updatedUser);
        return right(updatedUser);
      } else {
        return left(response.message ?? "فشل تحديث الملف الشخصي."); // ✅ تم إزالة ?? "..." (إذا كان الـ API يرجع رسالة)
      }
    } on DioException catch (e) {
      return left(ApiResponse.fromError(e).message);
    } catch (e) {
      return left("حدث خطأ غير متوقع أثناء تحديث الملف الشخصي: ${e.toString()}");
    }
  }
}
