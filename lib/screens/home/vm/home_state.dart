import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/load_state.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required LoadState loadState,
    required List<TodoEntity> todoList,
    required List<TodoEntity> completedList,
  }) = _HomeState;
}