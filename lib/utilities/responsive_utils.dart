import 'package:flutter/material.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';

typedef ResponsiveWidgetBuilder = Widget Function(ResponsiveUtility util);

class ResponsiveBuilder extends StatelessWidget {
  final ResponsiveUtility? util;

  final ResponsiveWidgetBuilder builder;
  const ResponsiveBuilder({Key? key,required this.builder, this.util})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(util ?? ResponsiveUtility(context: context));
  }
}

class ResponsiveUtility {
  final Size deviceSize;

  ResponsiveUtility({required BuildContext context})
      : deviceSize = MediaQuery.of(context).size;

  bool get isMobile => deviceSize.width <= widthMobile;

  bool get isDesktop => deviceSize.width >= widthDesktop;

  bool get isTablet =>
      deviceSize.width < widthDesktop && deviceSize.width > widthMobile;
}