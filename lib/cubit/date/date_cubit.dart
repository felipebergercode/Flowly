import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateTime?> {
  DateCubit() : super(null);

  void selectDate(DateTime date) {
    emit(date);
  }
}
