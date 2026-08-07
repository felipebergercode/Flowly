import 'package:bloc/bloc.dart';

part 'username_state.dart';

class UserNameCubit extends Cubit<UserNameState> {
  UserNameCubit() : super(const UserNameState());
  void saveName(String name) {
    emit(state.copyWith(userName: name));
  }

  void clearName() {
    emit(state.copyWith(userName: ''));
  }
}
