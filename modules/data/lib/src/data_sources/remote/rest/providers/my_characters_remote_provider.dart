import 'dart:math';

import 'package:dio/dio.dart';

import '../../../../dto/game_data_dto.dart';

final class MyCharactersRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const MyCharactersRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<GameDataDto> moveCharacter(String characterName, Point<int> position) async {
    final Uri url = Uri.https(_baseUrl, '/my/$characterName/action/move');
    final Response response = await _dio.post(
      url.toString(),
      data: {
        'x': position.x,
        'y': position.y,
      },
    );
    return GameDataDto.fromJson(response.data['data']);
  }
}
