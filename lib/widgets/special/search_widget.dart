import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_date_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_time_widget.dart';
import 'package:flutter/material.dart';

class SearchEventWidget extends StatefulWidget {
  const SearchEventWidget({super.key});

  @override
  State<SearchEventWidget> createState() => _SearchEventWidgetState();
}

class _SearchEventWidgetState extends State<SearchEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const DatePickerWidget(
            "Date",
            18,
            double.infinity,
          ),
          const SizedBox(
            height: 15,
          ),
          const TimePickerWidget(
            "Time",
            18,
            double.infinity,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              "Let's Go",
              textSize: mainButtonSize,
              textWeight: FontWeight.bold,
              isDisabled: false,
              onPressed: () {
                Navigator.of(context).pushNamed(resultRoute);
              },
            ),
          ),
        ],
      ),
    );
  }
}
