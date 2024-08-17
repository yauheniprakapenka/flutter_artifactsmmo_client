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
          throw CharacterLockedException(characterName: characterName, message: message);
        case 490:
          throw CharacterAlreadyAtDestinationException(characterName: characterName, message: message);
        case 498:
          throw CharacterNotFoundException(characterName: characterName, message: message);
        case 499:
          throw CharacterCooldownException(characterName: characterName, message: message);
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
          throw CharacterLockedException(characterName: characterName, message: message);
        case 497:
          throw InventoryFullException(characterName: characterName, message: message);
        case 498:
          throw CharacterNotFoundException(characterName: characterName, message: message);
        case 499:
          throw CharacterCooldownException(characterName: characterName, message: message);
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

  Future<CharacterGameDataDto> actionTaskNew(String characterName) async {
    final String url = '$_baseUrl/my/$characterName/action/task/new';

    try {
      final Response response = await _dio.post(url);
      return CharacterGameDataDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 486:
          throw CharacterLockedException(characterName: characterName, message: message);
        case 489:
          throw CharacterAlreadyHasTask(characterName: characterName, message: message);
        case 498:
          throw CharacterNotFoundException(characterName: characterName, message: message);
        case 499:
          throw CharacterCooldownException(characterName: characterName, message: message);
        case 598:
          throw TasksMasterNotFoundOnMapException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<CharacterGameDataDto> actionTaskComplete(String characterName) async {
    final String url = '$_baseUrl/my/$characterName/action/task/complete';

    try {
      final Response response = await _dio.post(url);
      return CharacterGameDataDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 486:
          throw CharacterLockedException(characterName: characterName, message: message);
        case 487:
          throw CharacterHasNoTaskException(message);
        case 488:
          throw CharacterHasNotCompletedTaskException(message);
        case 497:
          throw InventoryFullException(characterName: characterName, message: message);
        case 498:
          throw CharacterNotFoundException(characterName: characterName, message: message);
        case 499:
          throw CharacterCooldownException(characterName: characterName, message: message);
        case 598:
          throw TasksMasterNotFoundOnMapException(message);
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
          throw CharactersNotFoundException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
