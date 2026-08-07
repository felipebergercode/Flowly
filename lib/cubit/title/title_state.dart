part of 'title_cubit.dart';

class TitleState {
  final String title;
  const TitleState({this.title = ''});
  TitleState copyWith({String? title}) {
    return TitleState(title: title ?? this.title);
  }
}