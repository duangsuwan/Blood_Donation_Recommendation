import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/blank_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            "MY",
            "PROFILE",
            titleBoxSize,
          ),
        ],
      ),
      const UnderConstructionWidget(),
    );
  }
}