import 'package:domain/domain.dart';

import '../datasources/remote/rest/providers/game_events_remote_provider.dart';
import '../dto/game_event_dto.dart';
import '../mappers/game_event_dto_mapper.dart';

final class GameEventsRepositoryImpl implements GameEventsRepository {
  final GameEventsRemoteProvider _remoteDataSource;

  const GameEventsRepositoryImpl({
    required GameEventsRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<GameEvent>> getAllEvents() async {
    final List<GameEventDto> eventsDto = await _remoteDataSource.getAllEvents();
    final List<GameEvent> events = eventsDto.map((GameEventDto e) => e.asDomain).toList();
    return events;
  }
}
