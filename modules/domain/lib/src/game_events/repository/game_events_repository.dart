import '../game_events.dart';

abstract interface class GameEventsRepository {
  const GameEventsRepository();

  /// Fetch events details.
  Future<List<GameEvent>> getAllEvents();
}
