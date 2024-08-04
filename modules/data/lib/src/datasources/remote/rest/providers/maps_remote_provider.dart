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
    final List<TileDto> allTiles = [];
    int currentPage = 1;
    int totalPages = 1;
    int total = 0;
    const int pageSize = 100;

    do {
      final String url = '$_baseUrl/maps/?page=$currentPage&size=$pageSize';
      final Response response = await _dio.get(url);
      final MapDetailsDto pageData = MapDetailsDto.fromMap(response.data);

      allTiles.addAll(pageData.tiles);
      totalPages = pageData.pages;
      total = pageData.total;
      currentPage++;
    } while (currentPage <= totalPages);

    return MapDetailsDto(
      tiles: allTiles,
      total: total,
      page: 1,
      size: allTiles.length,
      pages: 1,
    );
  }
}
