part of 'username_cubit.dart';

class UserNameState {
  final String userName;
  const UserNameState({this.userName = ''});
  UserNameState copyWith({String? userName}) {
    return UserNameState(userName: userName ?? this.userName);
  }
}
