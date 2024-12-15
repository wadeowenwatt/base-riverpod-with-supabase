import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/components/app_check_box.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_images.dart';
import 'package:todo_app/constants/app_text_style.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:todo_app/models/enum/load_state.dart';
import 'package:todo_app/models/list_animation_model.dart';
import 'package:todo_app/routing/routes.dart';
import 'package:todo_app/screens/home/vm/home_notifier.dart';
import 'package:todo_app/screens/home/vm/home_state.dart';
import 'package:todo_app/screens/home/widget/item_list_widget.dart';
import 'package:todo_app/utils/global_loading.dart';

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier()..fetchTodoData();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomeNotifier vmRead;

  final GlobalKey<SliverAnimatedListState> _listTodoKey =
      GlobalKey<SliverAnimatedListState>();
  final GlobalKey<SliverAnimatedListState> _listCompletedKey =
      GlobalKey<SliverAnimatedListState>();
  late ListAnimationModel<TodoEntity> _listTodo;
  late ListAnimationModel<TodoEntity> _listCompleted;

  @override
  void initState() {
    super.initState();
    stateListener();
    vmRead = ref.read(homeNotifierProvider.notifier);
    _listTodo = ListAnimationModel(
      listKey: _listTodoKey,
      removedItemBuilder: _buildRemoveTodoItem,
      initialItems: [],
    );
    _listCompleted = ListAnimationModel(
      listKey: _listCompletedKey,
      removedItemBuilder: _buildRemoveCompletedItem,
      initialItems: [],
    );
  }

  void stateListener() {
    ref.listenManual(homeNotifierProvider, (previous, next) {
      if (previous?.todoList != next.todoList) {
        _listTodo = ListAnimationModel(
          listKey: _listTodoKey,
          removedItemBuilder: _buildRemoveTodoItem,
          initialItems: next.todoList,
        );
      }
      if (previous?.completedList != next.completedList) {
        _listCompleted = ListAnimationModel(
          listKey: _listCompletedKey,
          removedItemBuilder: _buildRemoveCompletedItem,
          initialItems: next.completedList,
        );
      }
    });

    ref.listenManual(homeNotifierProvider, (previous, next) {
      if (next.loadState == LoadState.Loading) {
        Global.showLoading(context);
      } else {
        Global.hideLoading();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final vmWatch = ref.watch(homeNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.3,
                  child: Image.asset(
                    AppImages.appBarBackground,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            RefreshIndicator(
              onRefresh: () async {
                vmRead.fetchTodoData();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: CustomAppBar(
                        minExtent: 0,
                        maxExtent: height * 0.23,
                      ),
                    ),
                    if (vmWatch.todoList.isEmpty &&
                        vmWatch.completedList.isEmpty)
                      const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "You don't have any task!",
                            style: AppTextStyle.blackSemiBold,
                          ),
                        ),
                      ),
                    if (_listTodo.length != 0)
                      SliverAnimatedList(
                        key: _listTodoKey,
                        initialItemCount: _listTodo.length,
                        itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) {
                          BorderRadius? borderRadius;
                          if (_listTodo.length == 1) {
                            borderRadius = const BorderRadius.all(
                              Radius.circular(16),
                            );
                          } else {
                            if (index == 0) {
                              borderRadius = const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              );
                            }
                            if (index == _listTodo.length - 1) {
                              borderRadius = const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              );
                            }
                          }
                          return ItemListWidget(
                            isCompleted: false,
                            borderRadius: borderRadius,
                            item: _listTodo[index],
                            onChangedState: () {
                              _listCompleted.insert(
                                0,
                                _listTodo.removeAt(index),
                              );
                              vmRead.onCompleted(index);
                            },
                            animation: animation,
                            onDeleted: () {},
                          );
                        },
                      ),
                    if (vmWatch.completedList.isNotEmpty &&
                        vmWatch.todoList.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "Completed",
                            style: AppTextStyle.whiteSemiBold.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    if (_listCompleted.length != 0)
                      SliverAnimatedList(
                        key: _listCompletedKey,
                        initialItemCount: _listCompleted.length,
                        itemBuilder: (context, index, animation) {
                          BorderRadius? borderRadius;
                          if (_listCompleted.length == 1) {
                            borderRadius = const BorderRadius.all(
                              Radius.circular(16),
                            );
                          } else {
                            if (index == 0) {
                              borderRadius = const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              );
                            }
                            if (index == _listCompleted.length - 1) {
                              borderRadius = const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              );
                            }
                          }
                          return ItemListWidget(
                            isCompleted: true,
                            borderRadius: borderRadius,
                            item: _listCompleted[index],
                            onChangedState: () {
                              _listTodo.insert(
                                vmWatch.todoList.length,
                                _listCompleted.removeAt(index),
                              );
                              vmRead.onUncompleted(index);
                            },
                            animation: animation,
                            onDeleted: () {},
                          );
                        },
                      ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 100),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 16,
              left: 16,
              child: Container(
                color: AppColors.lightBackground,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(Routes.todoDetail).then(
                      (todoEntity) {
                        if (todoEntity != null) {
                          vmRead.fetchTodoData();
                          // _listTodo.insert(vmWatch.todoList.length,
                          //     todoEntity as TodoEntity);
                        }
                      },
                    );
                  },
                  child: Text(
                    "Add New Task",
                    style: AppTextStyle.whiteBold.copyWith(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveTodoItem(
    TodoEntity item,
    BuildContext context,
    Animation<double> animation,
  ) {
    final vmWatch = ref.watch(homeNotifierProvider);
    return ItemListWidget(
      isCompleted: false,
      item: item,
      animation: animation,
      onChangedState: () => vmRead.onCompleted(vmWatch.todoList.indexOf(item)),
      onDeleted: () {},
    );
  }

  Widget _buildRemoveCompletedItem(
    TodoEntity item,
    BuildContext context,
    Animation<double> animation,
  ) {
    final vmWatch = ref.watch(homeNotifierProvider);
    return ItemListWidget(
      isCompleted: true,
      item: item,
      animation: animation,
      onChangedState: () =>
          vmRead.onUncompleted(vmWatch.todoList.indexOf(item)),
      onDeleted: () {},
    );
  }
}

class CustomAppBar extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  const CustomAppBar({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final width = MediaQuery.of(context).size.width;
    final ratio = shrinkOffset / maxExtent;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: maxExtent,
        ),
        Positioned(
          top: 24,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: ratio == 0
                ? 1
                : 0.5 > ratio
                    ? 0.5 - ratio
                    : 0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 100),
              scale: 1 - ratio,
              child: Text(
                DateFormat("MMMM d, yyyy").format(DateTime.now()),
                style: AppTextStyle.whiteSemiBold.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: 1 - ratio,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 100),
              scale: 1 - ratio,
              child: Text(
                "My Todo List",
                style: AppTextStyle.whiteBold.copyWith(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}
