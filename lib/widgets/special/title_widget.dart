import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';

class TitleWidget extends StatelessWidget {
  final String firstMessage;
  final String secondMessage;
  final double panelWidth;
  const TitleWidget(this.firstMessage, this.secondMessage, this.panelWidth,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: panelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextStyleWidget(
              firstMessage,
              textSize: titleTextSize,
              textWeight: FontWeight.bold,
              titleColor),
          const SizedBox(
            height: 10,
          ),
          TextStyleWidget(
              secondMessage,
              textSize: titleTextSize,
              textWeight: FontWeight.bold,
              titleColor),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
