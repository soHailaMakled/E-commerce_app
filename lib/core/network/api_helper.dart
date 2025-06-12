import 'package:dio/dio.dart';
import 'package:ntigradproject/core/network/api_response.dart';
import 'package:ntigradproject/core/network/api_configration.dart';
import 'package:ntigradproject/core/network/api_endpoint.dart'; // ✅ تأكد من هذا الـ import فقط لـ ApiEndpoint
// تأكدي من عدم وجود أي تعريف آخر لـ ApiEndpoint هنا في هذا الملف

class APIHelper {
  static final APIHelper _instance = APIHelper._internal();
  factory APIHelper() => _instance;
  APIHelper._internal();

  final Dio _dio = ApiConfigration.dioClient;

  Future<ApiResponse> login({required String username, required String password}) async {
    try {
      final FormData formData = FormData.fromMap({
        "username": username,
        "email": username,
        "password": password,
      });

      final response = await _dio.post(
        ApiEndpoint.login, // استخدام ApiEndpoint من الـ import
        data: formData,
      );
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (error) {
      return ApiResponse.fromError(error);
    }
  }

  Future<ApiResponse> request({
    required String method,
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      dynamic finalData = data;
      if (isFormData && data != null) {
        finalData = FormData.fromMap(data);
      }

      Response response;
      switch (method.toUpperCase()) {
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
          throw ArgumentError('Invalid HTTP method: $method');
      }

      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (error) {
      return ApiResponse.fromError(error);
    }
  }

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
