import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../../../dto/game_event_dto.dart';

final class GameEventsRemoteProvider {
  final Dio _dio;
  final String _baseUrl;

  const GameEventsRemoteProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  Future<List<GameEventDto>> getAllEvents() async {
    final String url = '$_baseUrl/events/?page=1&size=100';

    try {
      final Response response = await _dio.get(url);
      final List<dynamic> eventsMap = List.from(response.data['data']);
      return eventsMap.map((e) => GameEventDto.fromJson(e)).toList();
    } on DioException catch (e) {
      final String message = e.response?.data['error']['message'] ?? '';
      final int? statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 404:
          throw EventsNotFoundException(message);
        default:
          rethrow;
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
