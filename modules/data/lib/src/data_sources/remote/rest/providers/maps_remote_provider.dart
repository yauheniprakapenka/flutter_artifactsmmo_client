import 'package:dio/dio.dart';

import '../../../../dto/tile_dto.dart';

final class MapsRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const MapsRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<MapDetailsDto> getAllMaps() async {
    final String url = '$_baseUrl/maps/?page=1&size=50';
    final Response response = await _dio.get(url);
    final MapDetailsDto mapDetailsDto = MapDetailsDto.fromMap(response.data);
    return mapDetailsDto;
  }
}
