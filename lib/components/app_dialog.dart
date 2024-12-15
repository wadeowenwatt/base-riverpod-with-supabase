import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/constants/app_text_style.dart';

class AppDialog {
  void yesNoDialog(
    BuildContext context, {String? title,
        String? subTitle,
    String? titleYesButton,
    String? titleNoButton,
    Function? onTapYes,
    Function? onTapNo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "Alert",
            style: AppTextStyle.blackSemiBold,
          ),
          content: subTitle != null ? Text(
            subTitle,
            style: AppTextStyle.blackSemiBold,
          ) : null,
          actions: [
            TextButton(
              child: Text(titleYesButton ?? "Yes"),
              onPressed: () {
                if (onTapYes != null) {
                  onTapYes();
                }
                context.pop();
              },
            ),
            TextButton(
              child: Text(titleNoButton ?? "No"),
              onPressed: () {
                if (onTapNo != null) {
                  onTapNo();
                }
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
