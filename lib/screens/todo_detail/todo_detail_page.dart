import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/components/app_text_field.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_images.dart';
import 'package:todo_app/constants/app_text_style.dart';
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                                  // TODO: Title
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
                                            print(">>> $time");
                                          },
                                          // TODO: currentTime: vm.datePicker
                                        );
                                      },
                                      child: AppTextField(
                                        enabled: false,
                                        suffixIcon: Icon(
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
                                            print(">>> $time");
                                          },
                                          // TODO: currentTime: vm.timePicker
                                        );
                                      },
                                      child: AppTextField(
                                        enabled: false,
                                        suffixIcon: Icon(
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
                                onChanged: (text) {},
                                hintText: "Notes",
                                isMultipleLine: true,
                              )
                            ],
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
    return GestureDetector(
      onTap: () {
        /// TODO: onChangeCategory(categoryType)
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            /// TODO: if vm.valueSelect == categoryType => change color
            color: Colors.white,
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
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
