import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/login_widget.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
            "WELCOME",
            "DONOR",
            titleBoxSize,
          ),
        ],
      ),
      const LogInWidget(),
    );
  }
}
