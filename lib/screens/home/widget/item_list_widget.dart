import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/app_check_box.dart';
import 'package:todo_app/components/app_dialog.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/app_text_style.dart';
import 'package:todo_app/models/entity/todo_entity.dart';
import 'package:todo_app/models/enum/category_enum.dart';
import 'package:todo_app/routing/routes.dart';

class ItemListWidget extends ConsumerWidget {
  const ItemListWidget({
    super.key,
    required this.item,
    required this.animation,
    this.borderRadius,
    required this.onChangedState,
    required this.onDeleted,
    required this.isCompleted,
  });

  final TodoEntity item;
  final BorderRadius? borderRadius;
  final Function onChangedState;
  final Function onDeleted;
  final Animation<double> animation;
  final bool isCompleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(color: AppColors.lightDivider),
          ),
        ),
        child: isCompleted
            ? _buildListTileCompleted()
            : _buildListTileTodo(context),
      ),
    );
  }

  ListTile _buildListTileCompleted() {
    return ListTile(
      leading: Opacity(
        opacity: 0.5,
        child: Image.asset(
          item.category.icImage,
          width: 48,
          height: 48,
        ),
      ),
      title: Opacity(
        opacity: 0.5,
        child: Text(
          item.title,
          style: AppTextStyle.blackSemiBold.copyWith(
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ),
      subtitle: item.dateTime == null
          ? const SizedBox()
          : Opacity(
              opacity: 0.5,
              child: Text(
                DateFormat("MMM dd, yy hh:mm aa").format(item.dateTime!),
                style: AppTextStyle.greyMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black54,
                ),
              ),
            ),
      trailing: AppCheckBox(
        onChanged: (_) => onChangedState(),
        value: item.isCompleted,
      ),
    );
  }

  ListTile _buildListTileTodo(
    BuildContext context,
  ) {
    return ListTile(
      onTap: () {
        context.push(Routes.todoDetail);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return YesNoDialog(
              title: "Delete this todo?",
              onClickYes: onDeleted,
              onClickNo: () {},
            );
          },
        );
      },
      leading: Image.asset(
        item.category.icImage,
        width: 48,
        height: 48,
      ),
      title: Text(
        item.title,
        style: AppTextStyle.blackSemiBold,
      ),
      subtitle: item.dateTime == null
          ? const SizedBox()
          : Text(
              DateFormat("MMM dd, yy hh:mm aa").format(item.dateTime!),
              style: AppTextStyle.greyMedium.copyWith(
                decorationColor: Colors.black54,
              ),
            ),
      trailing: AppCheckBox(
        onChanged: (_) => onChangedState(),
        value: item.isCompleted,
      ),
    );
  }
}
