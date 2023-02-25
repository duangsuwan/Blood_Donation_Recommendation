import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/picker_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: TextStyleWidget(
              "Date",
              conditionsMessageColor,
              textSize: dateTimeLabelSize,
              textWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PickerWidget(
            getDate(),
            calendarIcon,
            onPressed: () {
              selectDate();
            },
          ),
        ],
      ),
    );
  }

  void selectDate() async {
    final todayDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: DateTime(todayDate.year - 5),
      lastDate: DateTime(todayDate.year + 5),
    );

    if (newDate == null) {
      return;
    }
    setState(() {
      selectedDate = newDate;
    });
  }

  String getDate() {
    return DateFormat.yMMMMd().format(selectedDate);
  }
}
