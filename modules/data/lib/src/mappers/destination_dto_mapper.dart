import 'package:domain/domain.dart';

import '../dto/destination_dto.dart';

extension DestinationDtoMapper on DestinationDto {
  Destination get asDomain {
    return Destination(
      name: name,
      x: x,
      y: y,
      content: content,
    );
  }
}
