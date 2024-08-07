import 'package:domain/domain.dart';

import '../datasources/remote/rest/providers/characters_remote_provider.dart';
import '../dto/character_dto.dart';
import '../mappers/character_dto_mapper.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteProvider _remoteDataSource;

  const CharactersRepositoryImpl({
    required CharactersRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Character> getCharactersByName(String name) async {
    final CharacterDto characterDto = await _remoteDataSource.getCharactersByName(name);
    return characterDto.asDomain;
  }
}
