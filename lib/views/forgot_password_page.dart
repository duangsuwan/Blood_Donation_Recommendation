import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/blank_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return PageWidget(
      Column(
        children: const [
          ImageWidget(
            logoBoxWidth,
            logoBoxHeight,
            logoImage,
          ),
          SizedBox(
            height: sizeBetweenLogoTitle,
          ),
          TitleWidget(
            "FORGOT",
            "PASSWORD",
            titleBoxSize,
          ),
        ],
      ),
      const UnderConstructionWidget(),
    );
  }
}
