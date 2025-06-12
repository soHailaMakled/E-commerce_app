import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // لإضافة kDebugMode
import 'package:ntigradproject/core/network/api_base_url.dart'; // ✅ تم إضافة هذا الـ import

abstract class ApiConfigration {
  static BaseOptions get baseOptions {
    return BaseOptions(
      baseUrl: ApiBaseUrl.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  static Dio get dioClient {
    final dio = Dio(baseOptions);

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          logPrint: (Object obj) => debugPrint(obj.toString()),
        ),
      );
    }

    return dio;
  }
}
