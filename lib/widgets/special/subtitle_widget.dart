import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class SubTitleWidget extends StatelessWidget {
  const SubTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextStyleWidget(
          " 0 Blood Donation Event",
          dateTimeColor,
          textSize: 16,
          textWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 60,
        ),
        Center(
          child: Column(
            children: const [
              TextStyleWidget(
                "There is no blood",
                titleColor,
                textSize: 22,
                textWeight: FontWeight.bold,
              ),
              TextStyleWidget(
                "donation event",
                titleColor,
                textSize: 22,
                textWeight: FontWeight.bold,
              ),
              TextStyleWidget(
                "available for you",
                titleColor,
                textSize: 22,
                textWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
