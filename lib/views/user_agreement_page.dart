import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/blank_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:flutter/material.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({super.key});

  @override
  State<UserAgreementPage> createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
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
            "USER",
            "AGREEMENT",
            titleBoxSize,
          ),
        ],
      ),
      const UnderConstructionWidget(),
    );
  }
}
