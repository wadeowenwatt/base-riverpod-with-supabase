import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/constants/app_constants.dart';
import 'package:todo_app/local_db/shared_preference.dart';
import 'package:todo_app/models/entity/todo_entity.dart';

class TodoService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> addTodo(TodoEntity todoEntity) async {
    try {
      final response = await supabase
          .from(AppConstants.tableName)
          .insert(todoEntity.toJson());
    } catch (e) {
      debugPrint("Add todo error: $e");
    }
  }

  Future<List<TodoEntity>?> fetchTodoList() async {
    try {
      List<TodoEntity> result = [];
      final udid = await SharedPreference.getUDID();
      final response = await supabase
          .from(AppConstants.tableName)
          .select()
          .eq("user_id", udid ?? "");
      if (response.isNotEmpty) {
        for (var json in response) {
          result.add(TodoEntity.fromJson(json));
        }
      }
      print(result.length);
      return result;
    } catch (e) {
      debugPrint("Fetch todo error: $e");
      return [];
    }
  }

  Future<void> updateTodo({
    required TodoEntity todoEntity,
  }) async {
    try {
      final response = await supabase
          .from(AppConstants.tableName)
          .update(todoEntity.toJson())
          .eq('id', todoEntity.id!);
    } catch (e) {
      debugPrint("Update todo error: $e");
    }
  }
}
