import 'package:bloc/bloc.dart';

part 'title_state.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(const TitleState());

  void saveTitle(String title) => emit(state.copyWith(title: title));

  void clearTitle() => emit(state.copyWith(title: ''));
}