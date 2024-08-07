import 'package:core/core.dart';
import 'package:domain/domain.dart';

extension TileContentLocaleMapper on TileContent {
  String get asLocalizeCode {
    switch (type) {
      case TileContentType.bank:
        return '';
      case TileContentType.monster:
        return code.capitalizeFirstLetter;
      case TileContentType.resource:
        return code.replaceUnderscoresWithSpaces().capitalizeFirstLetter;
      case TileContentType.tasks_master:
        return code.capitalizeFirstLetter;
      case TileContentType.workshop:
        return code.capitalizeFirstLetter;
      case TileContentType.grand_exchange:
        return '';
      default:
        return 'Unknown content type: ${type.name}';
    }
  }
}
