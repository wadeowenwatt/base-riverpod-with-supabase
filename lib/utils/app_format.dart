import 'package:intl/intl.dart';

class AppFormat {
  String dateFormat(DateTime time) {
    return DateFormat("dd/MM/yyyy").format(time);
  }

  String timeFormat(DateTime time) {
    return DateFormat("HH:mm").format(time);
  }

  String formatDateTimeToPlus7Offset(DateTime? dateTime) {
    String? iso8601 = dateTime?.toIso8601String();
    iso8601 = "${iso8601?.split(".")[0]}+07";
    return iso8601;
  }
}