import 'dart:developer';

enum TileContentTypeDto {
  bank('bank'),
  grand_exchange('grand_exchange'),
  monster('monster'),
  resource('resource'),
  tasks_master('tasks_master'),
  workshop('workshop'),
  unknown('unknown');

  final String type;

  const TileContentTypeDto(this.type);

  factory TileContentTypeDto.fromType(String type) {
    return TileContentTypeDto.values.firstWhere((TileContentTypeDto element) {
      return element.type.toLowerCase() == type.toLowerCase();
    }, orElse: () {
      log('Unknown tile content type: $type');
      return TileContentTypeDto.unknown;
    });
  }
}
