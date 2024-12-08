import 'package:todo_app/constants/app_images.dart';

enum CategoryEnum {
  TASK,
  GOAL,
  EVEN,
}

extension CategoryExtension on CategoryEnum {
  String get icImage {
    switch (this) {
      case CategoryEnum.TASK:
        return AppImages.icTask;
      case CategoryEnum.GOAL:
        return AppImages.icGoal;
      case CategoryEnum.EVEN:
        return AppImages.icEvent;
    }
  }

  int get id {
    switch (this) {
      case CategoryEnum.TASK:
        return 0;
      case CategoryEnum.GOAL:
        return 1;
      case CategoryEnum.EVEN:
        return 2;
    }
  }
}