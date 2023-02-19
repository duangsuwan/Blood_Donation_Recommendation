import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
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
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              "Log Out",
              textSize: mainButtonSize,
              textWeight: FontWeight.bold,
              isDisabled: false,
              onPressed: tryLogOut,
            ),
          ),
        ],
      ),
    );
  }

  void tryLogOut() {
    Navigator.pop(context);
  }
}
