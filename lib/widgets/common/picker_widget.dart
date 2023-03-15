import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';

class PickerWidget extends StatelessWidget {
  final String textValue;
  final double textSize;
  final double widgetSize;
  final Widget suffixIcon;
  final VoidCallback onPressed;

  const PickerWidget(this.textValue, this.textSize, this.widgetSize, this.suffixIcon,
      {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widgetSize,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: textCustomColor,
          ),
        ),
        tileColor: textCustomColor,
        title: TextStyleWidget(
          textValue,
          dateTimeColor,
          textSize: textSize,
        ),
        trailing: suffixIcon,
        onTap: onPressed,
      ),
    );
  }
}
