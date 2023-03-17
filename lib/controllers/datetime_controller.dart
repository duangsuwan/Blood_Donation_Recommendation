import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeConverter {
  
  static String getDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  static String getTime(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }

  static String getDateTime(DateTime dateTime) {
     return DateFormat("MMMM dd, yyyy hh:mm a").format(dateTime);
  }

  static Timestamp combineDateTime(DateTime date, TimeOfDay time) {
    DateTime newDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return Timestamp.fromDate(newDateTime);
  }

}