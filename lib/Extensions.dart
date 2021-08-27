// ignore_for_file: file_names

import 'package:intl/intl.dart';

String formatDate(DateTime _date, {String format = "MMM dd yyyy HH:mm:ss"}) {
  var formatter = DateFormat(format);
  return formatter.format(_date);
}

extension DateTimeExtension on DateTime {
  String toFormatterString() {
    return formatDate(this);
  }
}
