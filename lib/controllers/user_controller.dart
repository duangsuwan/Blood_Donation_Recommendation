import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/messages.dart';

class UserVerification {

  static bool isFullNameValid(String fullName, {bool skipEmpty = true}) {
    if (fullName.length >= 3 || (skipEmpty && fullName.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isEmailAddressValid(String emailAddress, {bool skipEmpty = true}) {
    if (emailRegularExpression.hasMatch(emailAddress) ||
        (skipEmpty && emailAddress.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isPrimaryPasswordValid(String primaryPassword, {bool skipEmpty = true}) {
    if (passwordRegularExpression.hasMatch(primaryPassword) ||
        (skipEmpty && primaryPassword.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isSecondaryPasswordValid(String primaryPassword, String secondaryPassword, {bool skipEmpty = true}) {
    if (primaryPassword == secondaryPassword ||
        (skipEmpty && secondaryPassword.isEmpty)) {
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
  
  static bool isRegisterFormValid(String fullName, String emailAddress, String primaryPassword, String secondaryPassword, bool userAgreementChecked) {
    if ( isFullNameValid(fullName, skipEmpty: false) &&
         isEmailAddressValid(emailAddress, skipEmpty: false) &&
         isPrimaryPasswordValid(primaryPassword, skipEmpty: false) &&
         isSecondaryPasswordValid(primaryPassword, secondaryPassword, skipEmpty: false) &&
         isUserAgreementChecked(userAgreementChecked) ) {
      return true;
    }
    return false;
  }
  
  static bool isLogInFormValid(String emailAddress, String password) {
    if (isEmailAddressValid(emailAddress, skipEmpty: false) && password.isNotEmpty) {
      return true;
    }
    return false;
  }

}

class UserDecoration {

  static Icon getPrimaryPasswordIcon(bool isPasswordHidden) {
    if (isPasswordHidden) {
      return invisibleEyeIcon;
    }
    return visibleEyeIcon;
  }
  
  static Icon? getSecondaryPasswordIcon(String primaryPassword, String secondaryPassword) {
    if (secondaryPassword.isEmpty) {
      return null;
    } else if (UserVerification.isSecondaryPasswordValid(primaryPassword, secondaryPassword)) {
      return checkIcon;
    }
    return crossIcon;
  }

}