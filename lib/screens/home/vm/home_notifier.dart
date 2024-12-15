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
    print(
        ">>> ${allTodoList?.length} - ${todoList.length} - ${completedList.length}");
    state = state.copyWith(
      loadState: LoadState.Successed,
      todoList: todoList,
      completedList: completedList,
    );
  }

  Future<void> onCompleted(int index) async {
    final previousState = state.copyWith();
    state = state.copyWith(
      loadState: LoadState.Loading,
    );

    final itemChange = state.todoList[index].copyWith(isCompleted: true);
    final newListTodo = [...state.todoList]..removeAt(index);
    final newListCompleted = [...state.completedList, itemChange];
    state = state.copyWith(
        loadState: LoadState.Successed,
        todoList: newListTodo,
        completedList: newListCompleted
    );

    try {
      await service.updateTodo(todoEntity: itemChange);
    } catch (e) {
      state = previousState;
    }
  }

  Future<void> onUncompleted(int index) async {
    final previousState = state.copyWith();
    state = state.copyWith(
      loadState: LoadState.Loading,
    );

    final itemChange = state.completedList[index].copyWith(isCompleted: false);
    final newListCompleted = [...state.completedList]..removeAt(index);
    final newListTodo = [...state.todoList, itemChange];
    state = state.copyWith(
        loadState: LoadState.Successed,
        todoList: newListTodo,
        completedList: newListCompleted
    );

    try {
      await service.updateTodo(todoEntity: itemChange);
    } catch (e) {
      state = previousState;
    }
  }
}
