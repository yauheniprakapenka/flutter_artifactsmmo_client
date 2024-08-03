import 'dart:math';

import 'package:dio/dio.dart';

import '../../../../dto/character_dto.dart';
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
    final String url = '$_baseUrl/my/$characterName/action/move';
    final Response response = await _dio.post(
      url,
      data: {
        'x': position.x,
        'y': position.y,
      },
    );
    return GameDataDto.fromJson(response.data['data']);
  }

  Future<List<CharacterDto>> getAllMyCharacters() async {
    final String url = '$_baseUrl/my/characters';
    final Response response = await _dio.get(url);
    return (response.data['data'] as List).map((e) => CharacterDto.fromJson(e)).toList();
  }
}
