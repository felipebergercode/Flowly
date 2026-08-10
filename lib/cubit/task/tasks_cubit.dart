import 'package:flowly/models/priority.dart';
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

  void deleteTask(String taskId) {
    final updatedTasks = state.where((task) {
      return task.id != taskId;
    }).toList();

    emit(updatedTasks);
  }

  void deleteTaskFromBoard(String boardId) {
    final updatedTasks = state.where((task) {
      return task.boardId != boardId;
    }).toList();
    emit(updatedTasks);
  }
  //---------------
  // UPDATED TASKS
  // -------------
  //

  //
  //
  // EDITAR TITULO

  void updatedTaskTitle(String taskId, String newTitle) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(title: newTitle);
      } else
        return task;
    }).toList();
    emit(updatedTasks);
  }

  //EDITAR DESCRIPCION

  void updatedTaskDescription(String taskId, String newDescription) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(description: newDescription);
      } else
        return task;
    }).toList();
    emit(updatedTasks);
  }

  //EDITAR BOARD

  void updatedTaskBoard(String taskId, String newBoardId) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(boardId: newBoardId);
      } else
        return task;
    }).toList();
    emit(updatedTasks);
  }

  //EDITAR PRIORITY

  void updatedTaskPriority(String taskId, Priority newPriority) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(priority: newPriority);
      } else
        return task;
    }).toList();
    emit(updatedTasks);
  }

  // EDITAR DATE

  void updatedTaskDate(String taskId, DateTime newDate) {
    final updatedTasks = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(dueDate: newDate);
      } else
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
