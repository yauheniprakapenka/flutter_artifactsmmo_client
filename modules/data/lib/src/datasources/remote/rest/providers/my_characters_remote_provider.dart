import 'dart:developer' show log;
import 'dart:math' show Point;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../../../dto/character_dto.dart';
import '../../../../dto/character_game_data_dto.dart';

final class MyCharactersRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const MyCharactersRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<CharacterGameDataDto> actionMove(String characterName, Point<int> position) async {
    final String url = '$_baseUrl/my/$characterName/action/move';

    try {
      final Response response = await _dio.post(
        url,
        data: {'x': position.x, 'y': position.y},
      );
      return CharacterGameDataDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 404:
          throw MapNotFoundException(message);
        case 486:
          throw CharacterLockedException(message);
        case 490:
          throw CharacterAlreadyAtDestinationException(message);
        case 498:
          throw CharacterNotFoundException(message);
        case 499:
          throw CharacterCooldownException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<CharacterGameDataDto> actionFight(String characterName) async {
    final String url = '$_baseUrl/my/$characterName/action/fight';

    try {
      final Response response = await _dio.post(url);
      return CharacterGameDataDto.fromJson(response.data['data']);
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
          throw CharacterCooldownException(message);
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

    try {
      final Response response = await _dio.get(url);
      return (response.data['data'] as List).map((e) => CharacterDto.fromJson(e)).toList();
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 404:
          throw CharacterNotFoundException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
