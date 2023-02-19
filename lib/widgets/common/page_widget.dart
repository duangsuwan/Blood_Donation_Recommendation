import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/utility/responsive_utils.dart';
import 'package:blood_donation_recommendation/widgets/common/responsive_widget.dart';
import 'package:flutter/material.dart';

class PageWidget extends StatefulWidget {
  final Widget firstWidgetGroup;
  final Widget secondWidgetGroup;
  
  const PageWidget(this.firstWidgetGroup, this.secondWidgetGroup, {super.key});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                alignment: Alignment.center,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ResponsiveBuilder(
                      builder: (ResponsiveUtility responsiveUtility) => RowOrColumn(
                        showRow: !responsiveUtility.isMobile,
                        columnMainAxisSize: MainAxisSize.min,
                        children: [
                          ExpandedIf(
                            flex: 4,
                            expanded: !responsiveUtility.isMobile,
                            child: widget.firstWidgetGroup,
                          ),
                          ExpandedIf(
                            flex: 5,
                            expanded: !responsiveUtility.isMobile,
                            child: widget.secondWidgetGroup,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
