import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/models/board_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BoardsCubit extends HydratedCubit<BoardsState> {
  BoardsCubit() : super(const BoardsState());

  void addBoard(Board board) {
    emit(state.copyWith(boards: [...state.boards, board]));
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

  void deleteBoard(String boardId) {
    final updatedBoards = state.boards.where((comparacionBoard) {
      return comparacionBoard.id != boardId;
    }).toList();

    emit(state.copyWith(boards: updatedBoards));
  }
}
