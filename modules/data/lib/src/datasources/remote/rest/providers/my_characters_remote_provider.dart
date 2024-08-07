import 'dart:developer' show log;
import 'dart:math' show Point;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

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

  Future<GameDataDto> fightCharacter(String characterName) async {
    final String url = '$_baseUrl/my/$characterName/action/fight';

    try {
      final Response response = await _dio.post(url);
      return GameDataDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 486:
          throw CharacterLockedException(message);
        case 497:
          throw InventoryFullException(message);
        case 498:
          throw CharacterNotFoundException(message);
        case 499:
          throw CooldownException(message);
        case 598:
          throw MonsterNotFoundException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<CharacterDto>> getAllMyCharacters() async {
    final String url = '$_baseUrl/my/characters';
    final Response response = await _dio.get(url);
    return (response.data['data'] as List).map((e) => CharacterDto.fromJson(e)).toList();
  }
}
