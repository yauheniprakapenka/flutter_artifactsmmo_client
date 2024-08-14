import 'package:domain/domain.dart';

import '../dto/task_content_type_dto.dart';

extension TaskContentTypeDtoMapper on TaskContentTypeDto {
  TaskContentType get asDomain {
    switch (this) {
      case TaskContentTypeDto.monsters:
        return TaskContentType.monsters;
      case TaskContentTypeDto.noTask:
        return TaskContentType.noTask;
      case TaskContentTypeDto.unknown:
        return TaskContentType.unknown;
    }
  }
}
