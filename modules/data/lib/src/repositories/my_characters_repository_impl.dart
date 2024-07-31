import 'dart:math';

import 'package:domain/domain.dart';

import '../data_sources/remote/rest/providers/my_characters_remote_provider.dart';

final class MyCharacterRepositoryImpl implements MyCharacterRepository {
  final MyCharactersRemoteProvider _remoteDataSource;

  const MyCharacterRepositoryImpl({
    required MyCharactersRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<void> actionMove(String characterName, Point<int> position) async {
    try {
      await _remoteDataSource.moveCharacter(characterName, position);
    } on Exception catch (e) {
      throw Exception('Failed to move character: $e');
    }
  }
}
