import 'package:dio/dio.dart';

final class DioClient {
  static DioClient? _instance;
  final Dio _dio;

  DioClient._internal(String token) : _dio = Dio() {
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  factory DioClient({required String token}) {
    _instance ??= DioClient._internal(token);
    return _instance!;
  }

  Dio get dio => _dio;
}
