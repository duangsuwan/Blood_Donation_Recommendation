import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeConverter {
  
  static String getDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  static String getTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }

}