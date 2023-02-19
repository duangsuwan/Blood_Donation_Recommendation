import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/page_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/search_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/title_widget.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            "DONATION",
            "TIME",
            titleBoxSize,
          ),
        ],
      ),
      const SearchEventWidget(),
    );
  }
}