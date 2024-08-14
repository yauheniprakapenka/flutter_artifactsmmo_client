import 'dart:developer';

enum TaskContentTypeDto {
  monsters('monsters'),
  noTask(''),
  unknown('unknown');

  final String type;

  const TaskContentTypeDto(this.type);

  factory TaskContentTypeDto.fromType(String type) {
    return TaskContentTypeDto.values.firstWhere((TaskContentTypeDto element) {
      return element.type.toLowerCase() == type.toLowerCase();
    }, orElse: () {
      log('Unknown task content type: $type');
      return TaskContentTypeDto.unknown;
    });
  }
}
