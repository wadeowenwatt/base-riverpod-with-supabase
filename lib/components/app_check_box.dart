import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  void changeState() {
    setState(() {
      value = !value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeState();
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: value
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.primaryColor,
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                color: Colors.white,
              ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
