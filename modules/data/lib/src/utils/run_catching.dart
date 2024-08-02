import 'package:dio/dio.dart';

Future<T> runCatching<T>(Future<T> Function() operation) async {
  try {
    return await operation();
  } on DioException catch (e) {
    final Object? error = e.error;
    if (error is FormatException) {
      throw Exception(error.message);
    }

    switch (e.type) {
      case DioExceptionType.connectionError:
        throw Exception('Check the connection with the server.\n${e.message}');
      case DioExceptionType.unknown:
        throw Exception(e.error);
      case DioExceptionType.badResponse:
        throw Exception(e.response?.data);
      default:
        throw Exception(e.response?.data);
    }
  } on Exception {
    rethrow;
  }
}
