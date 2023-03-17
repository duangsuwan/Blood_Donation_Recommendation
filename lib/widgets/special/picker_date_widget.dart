import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/controllers/datetime_controller.dart';
import 'package:blood_donation_recommendation/widgets/common/picker_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String titleValue;
  final double textSize;
  final double pickerSize;

  const DatePickerWidget(this.titleValue, this.textSize, this.pickerSize,
      {super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();

  DateTime getDateFromPicker() {
    return _DatePickerWidgetState().selectedDate;
  }
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: TextStyleWidget(
              widget.titleValue,
              conditionsMessageColor,
              textSize: dateTimeLabelSize,
              textWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PickerWidget(
            DateTimeConverter.getDate(selectedDate),
            widget.textSize,
            widget.pickerSize,
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
}
