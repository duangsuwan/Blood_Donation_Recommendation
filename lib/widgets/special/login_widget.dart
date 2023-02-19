import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/views/forgot_password_page.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/widgets/common/textfield_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String emailAddress = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {
          emailAddress = _emailController.text.trim();
        });
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        setState(() {
          password = _passwordController.text.trim();
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
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            "Enter your password",
            dataController: _passwordController,
            isTextHidden: true,
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
              onPressed: tryLogIn,
              isDisabled: !isFormValid(),
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
                  Navigator.pushNamed(context, registerRoute);
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

  bool isFormValid() {
    if (emailAddress.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  void tryLogIn() {}
}
