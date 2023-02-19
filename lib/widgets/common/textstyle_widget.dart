import 'package:flutter/material.dart';

class TextStyleWidget extends StatelessWidget {
  final String textValue;
  final double? textSize;
  final FontWeight? textWeight;
  final Color textColor;
  
  const TextStyleWidget(
    this.textValue,   
    this.textColor, 
    {this.textSize, this.textWeight, super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: textWeight,
        color: textColor,
      ),
    );
  }
}