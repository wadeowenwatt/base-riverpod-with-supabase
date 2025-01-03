import 'package:equatable/equatable.dart';
import 'package:todo_app/models/enum/category_enum.dart';

class TodoEntity extends Equatable {
  int? id;
  String title;
  String? notes;
  String userId;
  CategoryEnum category;
  DateTime? dateTime;
  bool isCompleted;

  TodoEntity({
    this.id,
    required this.userId,
    required this.title,
    this.notes,
    this.category = CategoryEnum.TASK,
    this.dateTime,
    this.isCompleted = false,
  });

  factory TodoEntity.fromJson(dynamic json) {
    return TodoEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userId: json['user_id'],
      title: json['title'] as String,
      notes: json['notes'] as String?,
      category: CategoryExtension.getTypeFromId(json['category']),
      dateTime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'notes': notes,
        'user_id': userId,
        'category': category.id,
        'datetime': dateTime?.toIso8601String(),
        'is_completed': isCompleted,
      };

  TodoEntity copyWith({
    int? id,
    String? title,
    String? notes,
    String? userId,
    CategoryEnum? category,
    DateTime? dateTime,
    bool? isCompleted,
  }) {
    return TodoEntity(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id, title: $title, notes: $notes, userId: $userId, category: $category, dateTime: $dateTime, isCompleted: $isCompleted}';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        notes,
        category,
        dateTime,
        isCompleted,
      ];
}
