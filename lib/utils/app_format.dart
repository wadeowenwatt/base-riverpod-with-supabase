import 'package:intl/intl.dart';

class AppFormat {
  String dateFormat(DateTime time) {
    return DateFormat("dd/MM/yyyy").format(time);
  }

  String timeFormat(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }
}