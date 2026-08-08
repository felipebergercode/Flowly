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
    required this.id,
    required this.title,
    required this.description,
    required this.boardId,
    required this.priority,
    required this.dueDate,
    this.status = TaskStatus.todo,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? boardId,
    Priority? priority,
    DateTime? dueDate,
    TaskStatus? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      boardId: boardId ?? this.boardId,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }
}
