import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/local_db/shared_preference.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:todo_app/models/enum/load_state.dart';
import 'package:todo_app/screens/todo_detail/vm/todo_detail_state.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoDetailNotifier extends StateNotifier<TodoDetailState> {
  TodoDetailNotifier()
      : super(
          TodoDetailState(
            loadState: LoadState.Init,
            draftTodo: TodoEntity(
              title: "",
              userId: "",
              category: CategoryEnum.TASK,
            ),
          ),
        );

  TodoService service = TodoService();

  void initTodoEntity(TodoEntity todoEntity) {
    state = state.copyWith(
      draftTodo: todoEntity,
    );
  }

  Future<void> saveNewTodo() async {
    state = state.copyWith(
      loadState: LoadState.Loading,
    );
    final udid = await SharedPreference.getUDID();
    var todoEntity = state.draftTodo.copyWith(
      userId: udid,
    );
    await service.addTodo(todoEntity);
    state = state.copyWith(
      loadState: LoadState.Successed,
    );
  }

  void onChangedCategory(CategoryEnum categoryEnum) {
    state = state.copyWith(
      draftTodo: state.draftTodo.copyWith(
        category: categoryEnum,
      ),
    );
  }

  void onChangedDate(DateTime date) {
    state = state.copyWith(
      draftTodo: state.draftTodo.copyWith(
        dateTime: date,
      ),
    );
  }

  void onChangedTitle(String text) {
    state = state.copyWith(
      draftTodo: state.draftTodo.copyWith(
        title: text,
      ),
    );
  }

  void onChangedNotes(String text) {
    state = state.copyWith(
      draftTodo: state.draftTodo.copyWith(
        notes: text,
      ),
    );
  }

  Future<void> updateTodo() async {
    state = state.copyWith(
      loadState: LoadState.Loading,
    );
    print(state.draftTodo.title);
    await service.updateTodo(todoEntity: state.draftTodo);
    state = state.copyWith(
      loadState: LoadState.Successed,
    );
  }


}
