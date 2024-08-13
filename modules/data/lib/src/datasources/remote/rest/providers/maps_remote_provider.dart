import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../../../dto/map_details_dto.dart';
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

    try {
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
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 404:
          throw MapNotFoundException(message);

        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
