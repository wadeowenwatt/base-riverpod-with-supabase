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
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:todo_app/models/enum/load_state.dart';
import 'package:todo_app/routing/routes.dart';
import 'package:todo_app/screens/home/vm/home_notifier.dart';
import 'package:todo_app/screens/home/vm/home_state.dart';
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

  @override
  void initState() {
    super.initState();
    vmRead = ref.read(homeNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final vmWatch = ref.watch(homeNotifierProvider);

    ref.listen(homeNotifierProvider, (previous, next) {
      if (next.loadState == LoadState.Loading) {
        Global.showLoading(context);
      } else {
        Global.hideLoading();
      }
    });

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
                    vmWatch.todoList.isEmpty && vmWatch.completedList.isEmpty
                        ? const SliverFillRemaining(
                            child: Center(
                              child: Text(
                                "You don't have any task!",
                                style: AppTextStyle.blackSemiBold,
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                BorderRadius? borderRadius;
                                if (vmWatch.todoList.length == 1) {
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
                                  if (index == vmWatch.todoList.length - 1) {
                                    borderRadius = const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    );
                                  }
                                }
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    color: Colors.white,
                                    border: (index != 6)
                                        ? const Border(
                                            bottom: BorderSide(
                                                color: AppColors.lightDivider),
                                          )
                                        : null,
                                  ),
                                  child: _buildListTileTodo(index),
                                );
                              },
                              childCount: vmWatch.todoList.length,
                            ),
                          ),
                    if (vmWatch.completedList.isNotEmpty)
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
                    if (vmWatch.completedList.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            BorderRadius? borderRadius;
                            if (vmWatch.completedList.length == 1) {
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
                              if (index == vmWatch.completedList.length - 1) {
                                borderRadius = const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                );
                              }
                            }
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: Colors.white,
                                border: (index != 5)
                                    ? const Border(
                                        bottom: BorderSide(
                                            color: AppColors.lightDivider),
                                      )
                                    : null,
                              ),
                              child: _buildListTileCompleted(index),
                            );
                          },
                          childCount: vmWatch.completedList.length,
                        ),
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
                      (value) {
                        if (value == true) vmRead.fetchTodoData();
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

  ListTile _buildListTileCompleted(int index) {
    final vmWatch = ref.watch(homeNotifierProvider);
    return ListTile(
      leading: Opacity(
        opacity: 0.5,
        child: Image.asset(
          vmWatch.completedList[index].category.icImage,
          width: 48,
          height: 48,
        ),
      ),
      title: Opacity(
        opacity: 0.5,
        child: Text(
          vmWatch.completedList[index].title,
          style: AppTextStyle.blackSemiBold.copyWith(
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ),
      subtitle: vmWatch.completedList[index].dateTime == null
          ? SizedBox()
          : Opacity(
              opacity: 0.5,
              child: Text(
                DateFormat("MMM dd, yy hh:mm aa")
                    .format(vmWatch.completedList[index].dateTime!),
                style: AppTextStyle.greyMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black54,
                ),
              ),
            ),
      trailing: AppCheckBox(
        onChanged: (_) {
          vmRead.onUncompleted(index);
        },
        value: vmWatch.completedList[index].isCompleted,
      ),
    );
  }

  ListTile _buildListTileTodo(int index) {
    final vmWatch = ref.watch(homeNotifierProvider);
    return ListTile(
      onTap: () {
        context.push(Routes.todoDetail, extra: vmWatch.todoList[index]);
      },
      leading: Image.asset(
        vmWatch.todoList[index].category.icImage,
        width: 48,
        height: 48,
      ),
      title: Text(
        vmWatch.todoList[index].title,
        style: AppTextStyle.blackSemiBold,
      ),
      subtitle: vmWatch.todoList[index].dateTime == null
          ? const SizedBox()
          : Text(
              DateFormat("MMM dd, yy hh:mm aa")
                  .format(vmWatch.todoList[index].dateTime!),
              style: AppTextStyle.greyMedium.copyWith(
                decorationColor: Colors.black54,
              ),
            ),
      trailing: AppCheckBox(
        onChanged: (_) {
          vmRead.onCompleted(index);
        },
        value: vmWatch.todoList[index].isCompleted,
      ),
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
