import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/controllers/user_controller.dart';
import 'package:blood_donation_recommendation/views/user_agreement_page.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/widgets/common/textfield_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/constants/colors.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _firstPasswordController;
  late final TextEditingController _secondPasswordController;
  String fullName = "";
  String emailAddress = "";
  String firstPassword = "";
  String secondPassword = "";
  bool userAgreementChecked = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {
          fullName = _nameController.text.trim();
        });
      });
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {
          emailAddress = _emailController.text.trim();
        });
      });
    _firstPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          firstPassword = _firstPasswordController.text.trim();
        });
      });
    _secondPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          secondPassword = _secondPasswordController.text.trim();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          TextFieldWidget(
            "Enter your full name",
            dataController: _nameController,
            isDataValid: UserVerification.isFullNameValid(fullName),
            errorMessage: "Invalid Name: Must be at least 3 characters in length",
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            "Enter your email address",
            dataController: _emailController,
            isDataValid: UserVerification.isEmailAddressValid(emailAddress),
            errorMessage: "Invalid Email Address",
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            "Enter your password",
            dataController: _firstPasswordController,
            isDataValid: UserVerification.isFirstPasswordValid(firstPassword),
            errorMessage:
                "Password must be at least 8 characters in length and contain at least one uppercase letter, lowercase letter, digit, and special character (!, %, @, #, \\, \$, &, *, or ~)",
            isTextHidden: true,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            "Confirm your password",
            dataController: _secondPasswordController,
            isDataValid: UserVerification.isSecondPasswordValid(firstPassword, secondPassword),
            errorMessage: "Password Mismatch",
            isTextHidden: true,
            fieldIcon: UserVerification.getSecondPasswordIcon(firstPassword, secondPassword),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: CheckboxListTile(
              value: userAgreementChecked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  userAgreementChecked = value!;
                });
              },
              title: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "You agree to the ",
                      style: TextStyle(
                        color: conditionsMessageColor,
                      ),
                    ),
                    TextSpan(
                      text: "terms and conditions",
                      style: const TextStyle(
                        color: conditionsLinkColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserAgreementPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              "Register",
              textSize: mainButtonSize,
              textWeight: FontWeight.bold,
              onPressed: tryRegister,
              isDisabled: !UserVerification.isRegisterFormValid(fullName, emailAddress, firstPassword, secondPassword, userAgreementChecked),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, loginRoute);
                },
                child: const TextStyleWidget(
                  "Sign In",
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

  void tryRegister() {}
}
