import 'package:equatable/equatable.dart';
import 'package:flowly/models/board_model.dart';

class BoardsState extends Equatable {
  final List<Board> boards;

  const BoardsState({this.boards = const []});

  BoardsState copyWith({List<Board>? boards}) {
    return BoardsState(boards: boards ?? this.boards);
  }

  @override
  List<Object> get props => [boards];
}
