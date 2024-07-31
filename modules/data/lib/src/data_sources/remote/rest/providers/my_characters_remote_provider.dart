import 'dart:math';

import 'package:dio/dio.dart';

final class MyCharactersRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const MyCharactersRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<Response> moveCharacter(String characterName, Point<int> position) async {
    final String url = 'https://$_baseUrl/my/$characterName/action/move';

    final Response response = await _dio.post(
      url,
      data: {
        'x': position.x,
        'y': position.y,
      },
    );
    return response;
  }
}
