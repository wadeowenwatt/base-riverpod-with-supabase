import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/constants/app_text_style.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    required this.title,
    required this.onClickYes,
    required this.onClickNo,
  });

  final String title;
  final Function? onClickYes;
  final Function? onClickNo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.3,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.blackSemiBold,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (onClickYes != null) {
                        onClickYes!();
                      }
                      context.pop();
                    },
                    child: const Text(
                      "Yes",
                      style: AppTextStyle.whiteSemiBold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text(
                      "No",
                      style: AppTextStyle.whiteSemiBold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

