import 'app_exception.dart';

class EventsNotFoundException implements AppException {
  @override
  final String message;

  const EventsNotFoundException(this.message);
}
