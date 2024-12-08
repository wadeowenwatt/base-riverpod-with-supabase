import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/load_state.dart';

part 'todo_detail_state.freezed.dart';

@freezed
class TodoDetailState with _$TodoDetailState {
  const factory TodoDetailState({
    required LoadState loadState,
    required TodoEntity draftTodo,

  }) = _TodoDetailState;
}