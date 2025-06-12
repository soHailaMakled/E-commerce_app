import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // مهم جداً للـ debugPrint و kDebugMode

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  // Factory method للتعامل مع ردود Dio الناجحة (status code 2xx)
  factory ApiResponse.fromResponse(Response response) {
    // لو الـ API بيرجع "status" بـ boolean
    bool successStatus = response.data?["status"] ?? (response.statusCode! >= 200 && response.statusCode! < 300);
    String responseMessage = response.data?["message"] ?? 'Operation successful.';

    return ApiResponse(
      status: successStatus,
      statusCode: response.statusCode ?? 200, // الافتراضي 200 للنجاح
      data: response.data,
      message: responseMessage,
    );
  }

  // Factory method للتعامل مع أخطاء Dio أو أي استثناءات أخرى
  factory ApiResponse.fromError(dynamic error) {
    if (error is DioException) {
      if (kDebugMode) { // بنطبع الـ Dio error بس في وضع الـ Debug
        debugPrint('Dio error: $error');
        debugPrint('Dio error response: ${error.response?.data}');
      }
      return ApiResponse(
        status: false,
        data: error.response?.data, // ممكن تكون null لو مفيش response
        statusCode: error.response?.statusCode ?? 500, // الافتراضي 500 للأخطاء
        message: _handleDioError(error),
      );
    } else {
      if (kDebugMode) { // بنطبع الأخطاء الأخرى بس في وضع الـ Debug
        debugPrint('Unknown error type: $error');
      }
      return ApiResponse(
        status: false,
        statusCode: 500, // الافتراضي 500 للأخطاء غير المعروفة
        message: 'An unexpected error occurred.',
      );
    }
  }

  // دالة ثابتة للتعامل مع أنواع أخطاء Dio المختلفة وتحويلها لرسالة واضحة
  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout, please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout, please check your internet connection.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout, please try again later.";
      case DioExceptionType.badResponse:
      // لو في response، يبقى فيه رسالة خطأ من السيرفر
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError: // أخطاء الاتصال بالإنترنت
        return "No internet connection. Please check your network.";
      case DioExceptionType.badCertificate:
        return "Bad SSL certificate. Please contact support."; // لو فيه مشكلة في الـ SSL
      case DioExceptionType.unknown:
      // لو فيه response بس النوع Unknown أو default
        if (error.response != null && error.response?.data != null) {
          return _handleServerError(error.response);
        }
        return "An unknown error occurred. Please try again.";
    }
  }

  /// دالة ثابتة للتعامل مع الأخطاء اللي بتيجي من رد السيرفر (مثل 400, 401, 404, 500)
  static String _handleServerError(Response? response) {
    if (kDebugMode) { // بنطبع الـ Server error response بس في وضع الـ Debug
      debugPrint('Server error response data: ${response?.data}');
      debugPrint('Server error status code: ${response?.statusCode}');
    }

    if (response == null) return "No response from server. Please try again.";

    // لو الـ response.data موجود وهو Map وفيه مفتاح "message"
    if (response.data is Map<String, dynamic> && response.data.containsKey("message")) {
      return response.data["message"].toString(); // بنرجع الرسالة اللي جاية من السيرفر
    }

    // ممكن نضيف معالجة لأنواع Status Codes معينة
    switch (response.statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Forbidden. You don't have permission to access this resource.";
      case 404:
        return "Resource not found.";
      case 422: // Validation error
      // لو الـ API بيرجع أخطاء validation في "errors" key مثلاً
        if (response.data is Map<String, dynamic> && response.data.containsKey("errors")) {
          // ممكن تعملي parse للـ errors دي وتجمعيهم في رسالة واحدة
          return "Validation error: ${response.data["errors"].toString()}";
        }
        return "Invalid data provided.";
      case 500:
        return "Internal server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "Server error: ${response.statusCode ?? 'Unknown'} - ${response.statusMessage ?? 'An error occurred.'}";
    }
  }
}