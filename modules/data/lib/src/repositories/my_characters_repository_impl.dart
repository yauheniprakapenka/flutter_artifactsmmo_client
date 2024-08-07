import 'dart:math';

import 'package:domain/domain.dart';

import '../datasources/remote/rest/providers/my_characters_remote_provider.dart';
import '../dto/character_dto.dart';
import '../dto/game_data_dto.dart';
import '../mappers/character_dto_mapper.dart';
import '../mappers/game_data_dto_mapper.dart';

final class MyCharacterRepositoryImpl implements MyCharacterRepository {
  final MyCharactersRemoteProvider _remoteDataSource;

  const MyCharacterRepositoryImpl({
    required MyCharactersRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<GameData> actionMove(String characterName, Point<int> position) async {
    final GameDataDto gameDataDto = await _remoteDataSource.actionMove(
      characterName,
      position,
    );
    return gameDataDto.asDomain;
  }

  @override
  Future<GameData> actionFight(String characterName) async {
    final GameDataDto fetchedGameDataDto = await _remoteDataSource.actionFight(characterName);
    return fetchedGameDataDto.asDomain;
  }

  @override
  Future<List<Character>> getAllMyCharacters() async {
    final List<CharacterDto> charactersDto = await _remoteDataSource.getAllMyCharacters();
    final List<Character> characters = charactersDto.map((CharacterDto e) => e.asDomain).toList();
    return characters;
  }
}
