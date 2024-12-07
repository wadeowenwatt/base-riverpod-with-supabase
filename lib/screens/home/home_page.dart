import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/app_check_box.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_images.dart';
import 'package:todo_app/constants/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                // Todo: refresh list todo
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverPersistentHeader(
                      delegate: CustomAppBar(
                        minExtent: 0,
                        maxExtent: height * 0.23,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          BorderRadius? borderRadius;
                          if (index == 0) {
                            borderRadius = BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            );
                          }
                          if (index == 6) {
                            borderRadius = BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: Colors.white,
                              border: (index != 6)
                                  ? Border(
                                      bottom: BorderSide(
                                          color: AppColors.lightDivider),
                                    )
                                  : null,
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                AppImages.icTask,
                                width: 48,
                                height: 48,
                              ),
                              title: Text("ete"),
                              subtitle: Text("ádasd"),
                              trailing: AppCheckBox(
                                onChanged: (valueChange) {
                                  // Todo: change
                                },
                                value: false,
                              ),
                            ),
                          );
                        },
                        childCount: 7,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          "Completed",
                          style: AppTextStyle.whiteSemiBold.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          BorderRadius? borderRadius;
                          if (index == 0) {
                            borderRadius = BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            );
                          }
                          if (index == 4) {
                            borderRadius = BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: Colors.white,
                              border: (index != 5)
                                  ? Border(
                                      bottom: BorderSide(
                                          color: AppColors.lightDivider),
                                    )
                                  : null,
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                AppImages.icEvent,
                                width: 48,
                                height: 48,
                              ),
                              title: Text("ete"),
                              subtitle: Text("ádasd"),
                              trailing: AppCheckBox(
                                onChanged: (valueChange) {
                                  // Todo: change
                                },
                                value: true,
                              ),
                            ),
                          );
                        },
                        childCount: 5,
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
                  onPressed: () {},
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
