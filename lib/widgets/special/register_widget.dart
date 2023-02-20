import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/constants/messages.dart';
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
  late final TextEditingController _primaryPasswordController;
  late final TextEditingController _secondaryPasswordController;

  String _fullName = "";
  String _emailAddress = "";
  String _primaryPassword = "";
  String _secondaryPassword = "";
  bool _userAgreementChecked = false;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {
          _fullName = _nameController.text.trim();
        });
      });
    _emailController = TextEditingController()
      ..addListener(() {
        setState(() {
          _emailAddress = _emailController.text.trim();
        });
      });
    _primaryPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          _primaryPassword = _primaryPasswordController.text.trim();
        });
      });
    _secondaryPasswordController = TextEditingController()
      ..addListener(() {
        setState(() {
          _secondaryPassword = _secondaryPasswordController.text.trim();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _primaryPasswordController.dispose();
    _secondaryPasswordController.dispose();
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
            isDataValid: UserVerification.isFullNameValid(_fullName),
            errorMessage: errorMessageFullName,
          ),
          const SizedBox(
            height: 15,
          ),
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
            dataController: _primaryPasswordController,
            isDataValid:
                UserVerification.isPrimaryPasswordValid(_primaryPassword),
            errorMessage: errorMessagePrimaryPassword,
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
            height: 15,
          ),
          TextFieldWidget(
            "Confirm your password",
            dataController: _secondaryPasswordController,
            isDataValid: UserVerification.isSecondaryPasswordValid(
                _primaryPassword, _secondaryPassword),
            errorMessage: errorMessageSecondaryPassword,
            isTextHidden: true,
            fieldIcon: UserDecoration.getSecondaryPasswordIcon(
                _primaryPassword, _secondaryPassword),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: CheckboxListTile(
              value: _userAgreementChecked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _userAgreementChecked = value!;
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
              onPressed: () {
                tryRegisterUser(
                    context,
                    _nameController.text.trim(),
                    _emailController.text.trim(),
                    _primaryPasswordController.text.trim());
              },
              isDisabled: !UserVerification.isRegisterFormValid(
                  _fullName,
                  _emailAddress,
                  _primaryPassword,
                  _secondaryPassword,
                  _userAgreementChecked),
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
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
}
