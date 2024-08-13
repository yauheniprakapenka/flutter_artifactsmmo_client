import '../../my_characters/entities/task_content_type.dart';

class ChatacterTask {
  final String task;
  final int taskProgress;
  final int taskTotal;
  final TaskContentType taskType;

  int get leftToComplete => taskTotal - taskProgress;

  const ChatacterTask({
    required this.task,
    required this.taskProgress,
    required this.taskTotal,
    required this.taskType,
  });
}
