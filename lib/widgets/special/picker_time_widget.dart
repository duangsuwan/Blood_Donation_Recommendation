import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/controllers/datetime_controller.dart';
import 'package:blood_donation_recommendation/widgets/common/picker_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final String titleValue;
  final double textSize;
  final double pickerSize;
  static TimeOfDay timeValue = getInitialTime();

  const TimePickerWidget(this.titleValue, this.textSize, this.pickerSize,
      {super.key});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();

  static TimeOfDay getInitialTime() {
    return TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  }

  TimeOfDay getTimeFromPicker() {
    return timeValue;
  }
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimePickerWidget.timeValue;

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
            DateTimeConverter.getTime(context, selectedTime),
            widget.textSize,
            widget.pickerSize,
            clockIcon,
            onPressed: () {
              selectTime();
            },
          ),
        ],
      ),
    );
  }

  void selectTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (newTime == null) {
      return;
    }
    setState(() {
      selectedTime = newTime;
      TimePickerWidget.timeValue = selectedTime;
    });
  }
}
