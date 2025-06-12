import 'package:dio/dio.dart';
import 'end_points.dart';

abstract class ApiConfigration {
  static BaseOptions option() => BaseOptions(
    baseUrl: ApiBaseUrl.baseUrl,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 60),
  );
}