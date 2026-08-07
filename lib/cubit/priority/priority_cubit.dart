import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flowly/models/priority.dart';

part 'priority_state.dart';

class PriorityCubit extends Cubit<Priority> {
  PriorityCubit() : super(Priority.low);

  void selectPriority(Priority priority) {
    emit(priority);
  }
}
