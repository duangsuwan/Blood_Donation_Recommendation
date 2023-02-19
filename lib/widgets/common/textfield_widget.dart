import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? dataController;
  final String fieldName;
  final Widget? fieldIcon;
  final bool isTextHidden;
  final bool isDataValid;
  final String? errorMessage;
  final TextInputType? fieldType;

  const TextFieldWidget(
    this.fieldName,
    { 
      this.dataController,
      this.fieldIcon,
      this.isTextHidden = false,
      this.isDataValid = true,
      this.errorMessage,
      this.fieldType,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    double borderRadius = 20;
    return TextField(
      controller: dataController,
      keyboardType: fieldType,
      obscureText: isTextHidden,
      decoration: InputDecoration(
          errorText: isDataValid ? null : errorMessage,
          errorMaxLines: 5,
          suffixIcon: fieldIcon,
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: errorMessageColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: errorMessageColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: textCustomColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: fieldBorderColor, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: textHintColor),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          hintText: fieldName,
          hintStyle: const TextStyle(color: textHintColor),
          fillColor: textCustomColor,
          filled: true,
      ),
    );
  }
}