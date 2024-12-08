import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/load_state.dart';
import 'package:todo_app/screens/home/vm/home_state.dart';
import 'package:todo_app/services/todo_service.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
      : super(
    const HomeState(
      loadState: LoadState.Init,
      todoList: [],
      completedList: [],
    ),
  );
  TodoService service = TodoService();

  Future<void> fetchTodoData() async {
    state = state.copyWith(
      loadState: LoadState.Loading,
    );
    List<TodoEntity>? allTodoList = await service.fetchTodoList();
    List<TodoEntity>? todoList = [];
    List<TodoEntity>? completedList = [];
    allTodoList?.forEach((todo) {
      if (todo.isCompleted == true) {
        completedList.add(todo);
      } else {
        todoList.add(todo);
      }
    });
    print(">>> ${allTodoList?.length} - ${todoList.length} - ${completedList.length}");
    state = state.copyWith(
      loadState: LoadState.Successed,
      todoList: todoList,
      completedList: completedList,
    );
  }

  Future<void> onCompleted(int index) async {
    state = state.copyWith(
      loadState: LoadState.Loading,
    );

    final itemChange = state.todoList[index];
    await service.updateTodo(todoId: itemChange.id!, isCompleted: true);
    await fetchTodoData();
  }

  Future<void> onUncompleted(int index) async {
    state = state.copyWith(
      loadState: LoadState.Loading,
    );
    final itemChange = state.completedList[index];
    await service.updateTodo(todoId: itemChange.id!, isCompleted: false);
    await fetchTodoData();
  }
}
