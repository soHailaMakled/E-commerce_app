import 'package:dio/dio.dart';
import '../local/local_data.dart';
import 'api_response.dart';
import 'end_points.dart';

class APIHelper {
  static final APIHelper _apiHelper = APIHelper._internal();
  factory APIHelper() => _apiHelper;
  APIHelper._internal();

  Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
    connectTimeout: Duration(seconds: 10),
    sendTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  // دالة login المعدلة لإرسال بيانات تسجيل الدخول كـ form-data مع إرسال كلا المفتاحين username و email
  Future<ApiResponse> login({required String username, required String password}) async {
    try {
      // تحويل البيانات إلى form-data، نرسل قيمة username في المفتاحين "username" و "email"
      FormData formData = FormData.fromMap({
        "username": username,
        "email": username, // إرسال نفس القيمة تحت مفتاح email
        "password": password,
      });
      var response = await dio.post(
        EndPoints.login,
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
      return ApiResponse.fromResponse(response);
    } catch (error) {
      return ApiResponse.fromError(error);
    }
  }

  // دالة postRequest العامة لاستخدامها في طلبات أخرى
  Future<ApiResponse> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
    bool isAuthorized = true,
    bool isFormData = false,
  }) async {
    try {
      dynamic finalData = data;
      if (isFormData) {
        finalData = FormData.fromMap(data);
      }
      var response = await dio.post(
        endPoint,
        data: finalData,
        options: Options(headers: {
          if (isAuthorized && LocalData.accessToken != null)
            "Authorization": "Bearer ${LocalData.accessToken ?? ''}"
        }),
      );
      return ApiResponse.fromResponse(response);
    } catch (error) {
      return ApiResponse.fromError(error);
    }
  }
}
