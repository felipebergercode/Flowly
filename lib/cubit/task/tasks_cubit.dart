import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class TasksCubit extends HydratedCubit<List<TaskModel>> {
  TasksCubit() : super([]);

  void addTask(TaskModel task) {
    emit([...state, task]);
  }

  void changeTaskStatus(String taskId, TaskStatus newStatus) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(status: newStatus);
      }

      return task;
    }).toList();

    emit(updatedTasks);
  }

  @override
  Map<String, dynamic> toJson(List<TaskModel> state) {
    return {'tasks': state.map((task) => task.toJson()).toList()};
  }

  @override
  List<TaskModel> fromJson(Map<String, dynamic> json) {
    final tasks = json['tasks'] as List;

    return tasks.map((task) => TaskModel.fromJson(task)).toList();
  }
}
