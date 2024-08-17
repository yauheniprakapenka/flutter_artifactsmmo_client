import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../../../dto/character_dto.dart';

final class CharactersRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const CharactersRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<CharacterDto> getCharactersByName(String characterName) async {
    final String url = '$_baseUrl/characters/$characterName';

    try {
      final Response response = await _dio.get(url);
      final CharacterDto characterDto = CharacterDto.fromJson(response.data['data']);
      return characterDto;
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 404:
          throw CharacterNotFoundException(characterName: characterName, message: message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
