import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';

class UserVerification {

  static bool isFullNameValid(String fullName, {bool skipEmpty = true}) {
    if (fullName.length >= 3 || (skipEmpty && fullName.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isEmailAddressValid(String emailAddress, {bool skipEmpty = true}) {
    RegExp emailRegularExpression = RegExp(
        r"^[a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+(\.[a-zA-Z0-9_-]+)*@[^-][a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,5})$");

    if (emailRegularExpression.hasMatch(emailAddress) ||
        (skipEmpty && emailAddress.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isFirstPasswordValid(String firstPassword, {bool skipEmpty = true}) {
    RegExp passwordRegularExpression =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!%@#\$&*~]).{8,}$');

    if (passwordRegularExpression.hasMatch(firstPassword) ||
        (skipEmpty && firstPassword.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isSecondPasswordValid(String firstPassword, String secondPassword, {bool skipEmpty = true}) {
    if (firstPassword == secondPassword ||
        (skipEmpty && secondPassword.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isUserAgreementChecked(bool userAgreementChecked) {
    if (userAgreementChecked) {
      return true;
    }
    return false;
  }
  
  static Icon? getSecondPasswordIcon(String firstPassword, String secondPassword, {bool skipEmpty = true}) {
    if (secondPassword.isEmpty) {
      return null;
    } else if (isSecondPasswordValid(firstPassword, secondPassword)) {
      return checkIcon;
    }
    return crossIcon;
  }

  static bool isRegisterFormValid(String fullName, String emailAddress, String firstPassword, String secondPassword, bool userAgreementChecked) {
    if ( isFullNameValid(fullName, skipEmpty: false) &&
         isEmailAddressValid(emailAddress, skipEmpty: false) &&
         isFirstPasswordValid(firstPassword, skipEmpty: false) &&
         isSecondPasswordValid(firstPassword, secondPassword, skipEmpty: false) &&
         isUserAgreementChecked(userAgreementChecked) ) {
      return true;
    }
    return false;
  }
  
  static bool isLogInFormValid(String emailAddress, String password) {
    if (emailAddress.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }

}