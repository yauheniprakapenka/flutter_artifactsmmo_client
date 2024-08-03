import 'package:domain/domain.dart';

import '../data_sources/remote/rest/providers/maps_remote_provider.dart';
import '../dto/tile_dto.dart';
import '../mappers/map_dto_mapper.dart';
import '../utils/run_catching.dart';

final class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteProvider _remoteDataSource;

  const MapsRepositoryImpl({
    required MapsRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<MapDetails> getAllMaps() async {
    final MapDetailsDto mapDetailsDto = await runCatching(() async {
      final MapDetailsDto mapDetailsDto = await _remoteDataSource.getAllMaps();
      return mapDetailsDto;
    });
    return mapDetailsDto.asDomain;
  }
}
