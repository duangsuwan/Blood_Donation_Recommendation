import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/constants/messages.dart';
import 'package:blood_donation_recommendation/views/forgot_password_page.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_date_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/widgets/common/textfield_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/controllers/user_controller.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _emailAddress = "";
  String _password = "";
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {
          _emailAddress = _emailController.text.trim();
        });
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        setState(() {
          _password = _passwordController.text.trim();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          TextFieldWidget(
            "Enter your email address",
            dataController: _emailController,
            isDataValid: UserVerification.isEmailAddressValid(_emailAddress),
            errorMessage: errorMessageEmailAddress,
            fieldType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            "Enter your password",
            dataController: _passwordController,
            isTextHidden: _isPasswordHidden,
            fieldIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordHidden = !_isPasswordHidden;
                });
              },
              icon: UserDecoration.getPrimaryPasswordIcon(_isPasswordHidden),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordPage(),
                ),
              );
            },
            child: const Text(
              "Forgot your password?",
              style: TextStyle(
                color: conditionsMessageColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              "Sign In",
              textSize: mainButtonSize,
              textWeight: FontWeight.bold,
              onPressed: () {
                DatePickerWidget.dateValue = DatePickerWidget.getInitialDate();
                TimePickerWidget.timeValue = TimePickerWidget.getInitialTime();
                tryLogIn(context, _emailController.text.trim(),
                    _passwordController.text.trim());
              },
              isDisabled:
                  !UserVerification.isLogInFormValid(_emailAddress, _password),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const TextStyleWidget(
                  "Sign Up",
                  titleColor,
                  textWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
