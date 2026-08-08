import 'package:flowly/models/task_model.dart';
import 'package:flowly/models/task_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<List<TaskModel>> {
  TasksCubit() : super([]);

  void addTask(TaskModel task) {
    emit([...state, task]);
    print('Cantidad de tasks: ${state.length}');
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
}
