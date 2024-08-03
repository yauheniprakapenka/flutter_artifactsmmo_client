import '../entities/map_details.dart';

abstract interface class MapsRepository {
  const MapsRepository();

  /// Fetch maps details.
  Future<MapDetails> getAllMaps();
}
