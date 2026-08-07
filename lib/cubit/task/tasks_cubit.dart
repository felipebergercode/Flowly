import 'package:flowly/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<List<TaskModel>> {
  TasksCubit() : super([]);

  void addTask(TaskModel task) {
    emit([...state, task]);
    print('Cantidad de tasks: ${state.length}');
  }
}
