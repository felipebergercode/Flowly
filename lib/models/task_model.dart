import 'package:flowly/models/priority.dart';
import 'package:flowly/models/task_status.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String boardId;
  final Priority priority;
  final DateTime dueDate;
  final TaskStatus status;

  const TaskModel({
    this.status = TaskStatus.todo,
    required this.id,
    required this.title,
    required this.description,
    required this.boardId,
    required this.priority,
    required this.dueDate,
  });
}
