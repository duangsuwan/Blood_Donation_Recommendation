import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/picker_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({super.key});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: TextStyleWidget(
              "Time",
              conditionsMessageColor,
              textSize: dateTimeLabelSize,
              textWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PickerWidget(
            getTime(),
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
      initialTime: selectedTime
    );

    if (newTime == null) {
      return;
    }
    setState(() {
      selectedTime = newTime;
    });
  }

  String getTime() {
    return selectedTime.format(context);
  }
}