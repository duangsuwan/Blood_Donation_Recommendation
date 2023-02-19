import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class UnderConstructionWidget extends StatefulWidget {
  const UnderConstructionWidget({super.key});

  @override
  State<UnderConstructionWidget> createState() =>
      _UnderConstructionWidgetState();
}

class _UnderConstructionWidgetState extends State<UnderConstructionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          const TextStyleWidget(
            "Under Construction",
            textSize: constructionMessageSize,
            conditionsMessageColor,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              "Back",
              textSize: mainButtonSize,
              textWeight: FontWeight.bold,
              isDisabled: false,
              onPressed: tryGoBack,
            ),
          ),
        ],
      ),
    );
  }

  void tryGoBack() {
    Navigator.pop(context);
  }
}
