import 'dart:math';

import 'package:domain/domain.dart';

import '../data_sources/remote/rest/providers/my_characters_remote_provider.dart';
import '../dto/game_data_dto.dart';
import '../mappers/game_data_dto_mapper.dart';
import '../utils/run_catching.dart';

final class MyCharacterRepositoryImpl implements MyCharacterRepository {
  final MyCharactersRemoteProvider _remoteDataSource;

  const MyCharacterRepositoryImpl({
    required MyCharactersRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<GameData> actionMove(String characterName, Point<int> position) async {
    final GameDataDto gameData = await runCatching(() async {
      final GameDataDto gameDataDto = await _remoteDataSource.moveCharacter(
        characterName,
        position,
      );
      return gameDataDto;
    });
    return gameData.asDomain;
  }
}
