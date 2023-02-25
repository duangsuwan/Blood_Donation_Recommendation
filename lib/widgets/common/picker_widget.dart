import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';

class PickerWidget extends StatelessWidget {
  final String textValue;
  final Widget suffixIcon;
  final VoidCallback onPressed;

  const PickerWidget(this.textValue, this.suffixIcon, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: textCustomColor,
          width: 1.5,
        ),
      ),
      tileColor: textCustomColor,
      title: TextStyleWidget(
        textValue,
        dateTimeColor,
        textSize: 18,
      ),
      trailing: suffixIcon,
      onTap: onPressed,
    );
  }
}
