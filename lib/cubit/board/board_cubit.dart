import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/models/board_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BoardsCubit extends HydratedCubit<BoardsState> {
  BoardsCubit() : super(const BoardsState());

  void addBoard(Board board) {
    emit(state.copyWith(boards: [...state.boards, board]));
  }

  void removeBoard(Board board) {
    final updatedBoards = List<Board>.from(state.boards)..remove(board);

    emit(state.copyWith(boards: updatedBoards));
  }

  void clearBoards() {
    emit(state.copyWith(boards: []));
  }

  @override
  Map<String, dynamic> toJson(BoardsState state) {
    return {'boards': state.boards.map((board) => board.toJson()).toList()};
  }

  @override
  BoardsState fromJson(Map<String, dynamic> json) {
    final boardsJson = json['boards'] as List;

    final boards = boardsJson.map((board) {
      return Board.fromJson(Map<String, dynamic>.from(board));
    }).toList();

    return BoardsState(boards: boards);
  }
}
