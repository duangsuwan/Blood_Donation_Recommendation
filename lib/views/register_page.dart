import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      Column(
        children: const [
          TitleWidget(
            "CREATE",
            "ACCOUNT",
            titleBoxSize,
          ),
        ],
      ),
      const RegisterWidget(),
    );
  }
}
