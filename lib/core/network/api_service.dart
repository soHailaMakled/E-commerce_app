import 'package:dio/dio.dart';
import 'package:ntigradproject/core/network/api_response.dart'; // تأكدي من المسار ده
import 'package:ntigradproject/core/network/api_configration.dart'; // import ملف إعدادات Dio
import 'package:ntigradproject/core/network/api_endpoint.dart'; // import ملف الـ Endpoints الموحد

class APIHelper {
  // تصميم Singleton لضمان وجود instance واحدة فقط من APIHelper
  static final APIHelper _instance = APIHelper._internal();
  factory APIHelper() => _instance;
  APIHelper._internal();

  // استخدام الـ Dio client الذي تم إعداده وتكوينه في ApiConfigration
  final Dio _dio = ApiConfigration.dioClient;

  // دالة login مخصصة لإرسال بيانات تسجيل الدخول
  // تأكدنا سابقاً من أن هذا Endpoint يتوقع "username" و "email" بنفس القيمة
  Future<ApiResponse> login({required String username, required String password}) async {
    try {
      final FormData formData = FormData.fromMap({
        "username": username,
        "email": username, // يُفترض أن الـ API يتوقع نفس القيمة لكلا المفتاحين
        "password": password,
      });

      final response = await _dio.post(
        ApiEndpoint.login, // استخدام الـ Endpoint الصحيح من ApiEndpoint
        data: formData, // Dio سيتعامل تلقائياً مع Content-Type: multipart/form-data
      );
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      // التعامل مع أخطاء Dio المحددة
      return ApiResponse.fromError(e);
    } catch (error) {
      // التعامل مع أي أخطاء أخرى غير متوقعة
      return ApiResponse.fromError(error);
    }
  }

  // دالة عامة لعمل أي نوع من طلبات الـ HTTP (GET, POST, PUT, DELETE)
  // هذه الدالة توفر مرونة عالية للتعامل مع أي طلب API
  Future<ApiResponse> request({
    required String method, // نوع الطلب (مثال: 'GET', 'POST', 'PUT', 'DELETE')
    required String endPoint, // الـ Endpoint المحدد للطلب
    Map<String, dynamic>? data, // البيانات التي سيتم إرسالها مع الطلب (لـ POST, PUT, DELETE)
    Map<String, dynamic>? queryParameters, // البارامترات التي تضاف للـ URL (لـ GET)
    bool isFormData = false, // هل البيانات ستُرسل كـ FormData؟
  }) async {
    try {
      dynamic finalData = data;
      if (isFormData && data != null) {
        finalData = FormData.fromMap(data); // تحويل البيانات إلى FormData إذا لزم الأمر
      }

      Response response;
      switch (method.toUpperCase()) { // تحويل نوع الطلب لأحرف كبيرة لتوحيد المعالجة
        case 'GET':
          response = await _dio.get(endPoint, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await _dio.post(endPoint, data: finalData);
          break;
        case 'PUT':
          response = await _dio.put(endPoint, data: finalData);
          break;
        case 'DELETE':
          response = await _dio.delete(endPoint, data: finalData);
          break;
        default:
          throw ArgumentError('Invalid HTTP method: $method'); // رمي خطأ لنوع طلب غير مدعوم
      }

      return ApiResponse.fromResponse(response); // إرجاع استجابة API منسقة
    } on DioException catch (e) {
      // التعامل مع أخطاء Dio المحددة وتحويلها لـ ApiResponse
      return ApiResponse.fromError(e);
    } catch (error) {
      // التعامل مع أي أخطاء عامة غير متوقعة
      return ApiResponse.fromError(error);
    }
  }

  // دوال مساعدة لسهولة استخدام أنواع الطلبات الشائعة (GET, POST, PUT, DELETE)
  // هذه الدوال تستدعي الدالة العامة 'request'
  Future<ApiResponse> get(String endPoint, {Map<String, dynamic>? queryParameters}) {
    return request(method: 'GET', endPoint: endPoint, queryParameters: queryParameters);
  }

  Future<ApiResponse> post(String endPoint, {required Map<String, dynamic> data, bool isFormData = false}) {
    return request(method: 'POST', endPoint: endPoint, data: data, isFormData: isFormData);
  }

  Future<ApiResponse> put(String endPoint, {required Map<String, dynamic> data, bool isFormData = false}) {
    return request(method: 'PUT', endPoint: endPoint, data: data, isFormData: isFormData);
  }

  Future<ApiResponse> delete(String endPoint, {Map<String, dynamic>? data}) {
    return request(method: 'DELETE', endPoint: endPoint, data: data);
  }
}
