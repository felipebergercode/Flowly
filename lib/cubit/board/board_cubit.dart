import 'package:flowly/cubit/board/board_state.dart';
import 'package:flowly/models/board_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardsCubit extends Cubit<BoardsState> {
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
}
