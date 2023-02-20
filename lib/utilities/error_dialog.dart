import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorText) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const TextStyleWidget(
          'An error occurred',
          dialogMessageColor,
        ),
        content: Text(errorText),
        actions: [
          ButtonWidget(
            'OK',
            textSize: dialogButtonSize,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
