import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String textValue;
  final double? textSize;
  final FontWeight? textWeight;
  final bool isDisabled;
  final VoidCallback onPressed;

  const ButtonWidget(this.textValue,
      {this.textSize, this.textWeight, this.isDisabled = false, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: isDisabled ? buttonDisableColor : buttonEnableColor),
      child: Text(
        textValue,
        style: TextStyle(
          color: textCustomColor,
          fontSize: textSize,
          fontWeight: textWeight,
        ),
      ),
    );
  }
}