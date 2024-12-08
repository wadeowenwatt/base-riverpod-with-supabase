import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/app_text_field.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_images.dart';
import 'package:todo_app/constants/app_text_style.dart';
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo_app/models/enum/load_state.dart';
import 'package:todo_app/screens/todo_detail/vm/todo_detail_notifier.dart';
import 'package:todo_app/screens/todo_detail/vm/todo_detail_state.dart';
import 'package:todo_app/utils/global_loading.dart';

final todoDetailNotifierProvider =
    StateNotifierProvider<TodoDetailNotifier, TodoDetailState>((ref) {
  return TodoDetailNotifier();
});

class TodoDetailPage extends ConsumerStatefulWidget {
  const TodoDetailPage({super.key});

  @override
  ConsumerState<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends ConsumerState<TodoDetailPage> {
  late TodoDetailNotifier vmRead;
  TextEditingController dateEditing = TextEditingController();
  TextEditingController timeEditing = TextEditingController();

  @override
  void initState() {
    super.initState();
    vmRead = ref.read(todoDetailNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final vmWatch = ref.watch(todoDetailNotifierProvider);
    ref.listen(todoDetailNotifierProvider, (previous, next) {
      if (next.loadState == LoadState.Loading) {
        Global.showLoading(context);
      } else {
        Global.hideLoading();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: CustomAppBarDetail(
                minExtent: height * 0.1,
                maxExtent: height * 0.1,
              ),
              floating: false,
              pinned: true,
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Task Title",
                                style: AppTextStyle.blackSemiBold.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AppTextField(
                                onChanged: (text) {
                                  vmRead.onChangedTitle(text);
                                },
                                hintText: "Task Title",
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Category",
                                style: AppTextStyle.blackSemiBold.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 24),
                              _buildItemCategory(
                                  categoryType: CategoryEnum.TASK),
                              const SizedBox(width: 16),
                              _buildItemCategory(
                                  categoryType: CategoryEnum.EVEN),
                              const SizedBox(width: 16),
                              _buildItemCategory(
                                  categoryType: CategoryEnum.GOAL),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style:
                                          AppTextStyle.blackSemiBold.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(
                                          context,
                                          minTime: DateTime(2000),
                                          maxTime: DateTime(2028),
                                          showTitleActions: true,
                                          onConfirm: (DateTime time) {
                                            vmRead.onChangedDate(time);
                                            dateEditing.text =
                                                DateFormat("dd/MM/yyyy")
                                                    .format(time);
                                          },
                                          currentTime:
                                              vmWatch.draftTodo.dateTime,
                                        );
                                      },
                                      child: AppTextField(
                                        controller: dateEditing,
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.calendar_today_outlined,
                                          color: AppColors.primaryColor,
                                        ),
                                        hintText: "Date",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time",
                                      style:
                                          AppTextStyle.blackSemiBold.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showTime12hPicker(
                                          context,
                                          showTitleActions: true,
                                          onConfirm: (DateTime time) {
                                            vmRead.onChangedDate(time);
                                            timeEditing.text =
                                                DateFormat("HH:mm")
                                                    .format(time);
                                          },
                                          currentTime:
                                              vmWatch.draftTodo.dateTime,
                                        );
                                      },
                                      child: AppTextField(
                                        controller: timeEditing,
                                        enabled: false,
                                        suffixIcon: const Icon(
                                          Icons.access_time_outlined,
                                          color: AppColors.primaryColor,
                                        ),
                                        hintText: "Time",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes",
                                style: AppTextStyle.blackSemiBold.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              AppTextField(
                                onChanged: (text) {
                                  vmRead.onChangedNotes(text);
                                },
                                hintText: "Notes",
                                isMultipleLine: true,
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: width,
                            child: ElevatedButton(
                              onPressed: () {
                                vmRead.saveNewTodo();
                              },
                              child: const Text(
                                "Save",
                                style: AppTextStyle.whiteSemiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemCategory({required CategoryEnum categoryType}) {
    final vmWatch = ref.watch(todoDetailNotifierProvider);

    return GestureDetector(
      onTap: () {
        vmRead.onChangedCategory(categoryType);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: vmWatch.draftTodo.category == categoryType
                ? AppColors.primaryColor
                : Colors.white,
            width: 1,
          ),
        ),
        child: Image.asset(
          categoryType.icImage,
          width: 48,
          height: 48,
        ),
      ),
    );
  }
}

class CustomAppBarDetail extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;

  @override
  final double maxExtent;

  const CustomAppBarDetail({
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: maxExtent,
          child: Image.asset(
            AppImages.appBarBackground,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          "Add New Task",
          style: AppTextStyle.whiteSemiBold.copyWith(
            fontSize: 16,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.close,
                size: 28,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}
