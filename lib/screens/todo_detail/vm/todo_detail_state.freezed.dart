// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodoDetailState {
  LoadState get loadState => throw _privateConstructorUsedError;
  TodoEntity get draftTodo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoDetailStateCopyWith<TodoDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDetailStateCopyWith<$Res> {
  factory $TodoDetailStateCopyWith(
          TodoDetailState value, $Res Function(TodoDetailState) then) =
      _$TodoDetailStateCopyWithImpl<$Res, TodoDetailState>;
  @useResult
  $Res call({LoadState loadState, TodoEntity draftTodo});
}

/// @nodoc
class _$TodoDetailStateCopyWithImpl<$Res, $Val extends TodoDetailState>
    implements $TodoDetailStateCopyWith<$Res> {
  _$TodoDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? draftTodo = null,
  }) {
    return _then(_value.copyWith(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      draftTodo: null == draftTodo
          ? _value.draftTodo
          : draftTodo // ignore: cast_nullable_to_non_nullable
              as TodoEntity,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoDetailStateImplCopyWith<$Res>
    implements $TodoDetailStateCopyWith<$Res> {
  factory _$$TodoDetailStateImplCopyWith(_$TodoDetailStateImpl value,
          $Res Function(_$TodoDetailStateImpl) then) =
      __$$TodoDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LoadState loadState, TodoEntity draftTodo});
}

/// @nodoc
class __$$TodoDetailStateImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailStateImpl>
    implements _$$TodoDetailStateImplCopyWith<$Res> {
  __$$TodoDetailStateImplCopyWithImpl(
      _$TodoDetailStateImpl _value, $Res Function(_$TodoDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadState = null,
    Object? draftTodo = null,
  }) {
    return _then(_$TodoDetailStateImpl(
      loadState: null == loadState
          ? _value.loadState
          : loadState // ignore: cast_nullable_to_non_nullable
              as LoadState,
      draftTodo: null == draftTodo
          ? _value.draftTodo
          : draftTodo // ignore: cast_nullable_to_non_nullable
              as TodoEntity,
    ));
  }
}

/// @nodoc

class _$TodoDetailStateImpl implements _TodoDetailState {
  const _$TodoDetailStateImpl(
      {required this.loadState, required this.draftTodo});

  @override
  final LoadState loadState;
  @override
  final TodoEntity draftTodo;

  @override
  String toString() {
    return 'TodoDetailState(loadState: $loadState, draftTodo: $draftTodo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDetailStateImpl &&
            (identical(other.loadState, loadState) ||
                other.loadState == loadState) &&
            (identical(other.draftTodo, draftTodo) ||
                other.draftTodo == draftTodo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loadState, draftTodo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDetailStateImplCopyWith<_$TodoDetailStateImpl> get copyWith =>
      __$$TodoDetailStateImplCopyWithImpl<_$TodoDetailStateImpl>(
          this, _$identity);
}

abstract class _TodoDetailState implements TodoDetailState {
  const factory _TodoDetailState(
      {required final LoadState loadState,
      required final TodoEntity draftTodo}) = _$TodoDetailStateImpl;

  @override
  LoadState get loadState;
  @override
  TodoEntity get draftTodo;
  @override
  @JsonKey(ignore: true)
  _$$TodoDetailStateImplCopyWith<_$TodoDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
