import 'package:domain/domain.dart';

import '../datasources/remote/rest/providers/maps_remote_provider.dart';
import '../dto/map_details_dto.dart';
import '../mappers/map_details_dto_mapper.dart';

final class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteProvider _remoteDataSource;

  const MapsRepositoryImpl({
    required MapsRemoteProvider remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<MapDetails> getAllMaps() async {
    final MapDetailsDto mapDetailsDto = await _remoteDataSource.getAllMaps();
    return mapDetailsDto.asDomain;
  }
}
