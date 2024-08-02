import 'package:dio/dio.dart';

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
    final Uri url = Uri.https(_baseUrl, '/characters/$characterName');
    final Response response = await _dio.get(url.toString());
    final CharacterDto characterDto = CharacterDto.fromJson(response.data['data']);
    return characterDto;
  }
}
