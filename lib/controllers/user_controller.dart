import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/utilities/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/messages.dart';
import 'package:blood_donation_recommendation/models/users.dart';

class UserVerification {
  static bool isFullNameValid(String fullName, {bool skipEmpty = true}) {
    if (fullName.length >= 3 || (skipEmpty && fullName.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isEmailAddressValid(String emailAddress,
      {bool skipEmpty = true}) {
    if (emailRegularExpression.hasMatch(emailAddress) ||
        (skipEmpty && emailAddress.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isPrimaryPasswordValid(String primaryPassword,
      {bool skipEmpty = true}) {
    if (passwordRegularExpression.hasMatch(primaryPassword) ||
        (skipEmpty && primaryPassword.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isSecondaryPasswordValid(
      String primaryPassword, String secondaryPassword,
      {bool skipEmpty = true}) {
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

  static bool isRegisterFormValid(
      String fullName,
      String emailAddress,
      String primaryPassword,
      String secondaryPassword,
      bool userAgreementChecked) {
    if (isFullNameValid(fullName, skipEmpty: false) &&
        isEmailAddressValid(emailAddress, skipEmpty: false) &&
        isPrimaryPasswordValid(primaryPassword, skipEmpty: false) &&
        isSecondaryPasswordValid(primaryPassword, secondaryPassword,
            skipEmpty: false) &&
        isUserAgreementChecked(userAgreementChecked)) {
      return true;
    }
    return false;
  }

  static bool isLogInFormValid(String emailAddress, String password) {
    if (isEmailAddressValid(emailAddress, skipEmpty: false) &&
        password.isNotEmpty) {
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

  static Icon? getSecondaryPasswordIcon(
      String primaryPassword, String secondaryPassword) {
    if (secondaryPassword.isEmpty) {
      return null;
    } else if (UserVerification.isSecondaryPasswordValid(
        primaryPassword, secondaryPassword)) {
      return checkIcon;
    }
    return crossIcon;
  }
}

void tryRegisterUser(BuildContext context, String fullName, String emailAddress,
    String password) async {
  try {
    NavigatorState state = Navigator.of(context);
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserDatabaseAccess.createUser(state, user.uid, fullName, emailAddress);
      state.pushNamed(searchRoute);
    } else {
      throw const FormatException();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      await showErrorDialog(
        context,
        'Weak password',
      );
    } else if (e.code == 'email-already-in-use') {
      await showErrorDialog(
        context,
        'Email is already in use',
      );
    } else if (e.code == 'invalid-email') {
      await showErrorDialog(
        context,
        'Invalid email',
      );
    } else {
      await showErrorDialog(
        context,
        'Error: ${e.code}',
      );
    }
  } on FormatException {
    await showErrorDialog(
      context,
      'Error: Cannot register your account',
    );
  } catch (e) {
    await showErrorDialog(
      context,
      e.toString(),
    );
  }
}

void tryLogIn(
    BuildContext context, String emailAddress, String password) async {
  try {
    NavigatorState state = Navigator.of(context);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      state.pushNamedAndRemoveUntil(
        searchRoute,
        (route) => false,
      );
    } else {
      throw const FormatException();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      await showErrorDialog(
        context,
        'User not found',
      );
    } else if (e.code == 'wrong-password') {
      await showErrorDialog(
        context,
        'Wrong credentials',
      );
    } else {
      await showErrorDialog(
        context,
        'Error: ${e.code}',
      );
    }
  } on FormatException {
    await showErrorDialog(
      context,
      'Error: Cannot log in to your account',
    );
  } catch (e) {
    await showErrorDialog(
      context,
      e.toString(),
    );
  }
}

void tryLogOut(BuildContext context) async {
  try {
    NavigatorState state = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    state.pushNamedAndRemoveUntil(loginRoute, (route) => false);
  } catch (e) {
    await showErrorDialog(
      context,
      e.toString(),
    );
  }
}