import 'dart:math';

import 'package:dio/dio.dart';

final class MyCharactersRemoteProvider {
  final Dio _dio;

  const MyCharactersRemoteProvider({
    required Dio dio,
  }) : _dio = dio;

  Future<Response> moveCharacter(String characterName, Point<int> position) async {
    final String url = 'https://api.artifactsmmo.com/my/$characterName/action/move';

    final Response response = await _dio.post(
      url,
      data: {
        'x': position.x,
        'y': position.y,
      },
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  }
}
