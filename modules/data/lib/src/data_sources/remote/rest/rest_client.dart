import 'package:dio/dio.dart';

final class DioClient {
  static DioClient? _instance;
  final Dio _dio;

  DioClient._internal(String token) : _dio = Dio() {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _dio.options.headers['accept'] = 'application/json';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  factory DioClient({required String token}) {
    _instance ??= DioClient._internal(token);
    return _instance!;
  }

  Dio get dio => _dio;
}
