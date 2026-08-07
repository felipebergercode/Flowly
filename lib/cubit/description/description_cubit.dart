import 'package:bloc/bloc.dart';
part 'description_state.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  DescriptionCubit() : super(DescriptionState());

  void saveDescription(String description) =>
      emit(state.copyWith(description: description));

  void clearDescription() => emit(state.copyWith(description: ''));
}
