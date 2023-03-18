import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/icons.dart';
import 'package:blood_donation_recommendation/constants/images.dart';
import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/controllers/user_controller.dart';
import 'package:blood_donation_recommendation/models/users.dart';
import 'package:blood_donation_recommendation/widgets/common/image_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_date_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_time_widget.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 25,
                bottom: 25,
              ),
              child: FutureBuilder<UserRecord>(
                future: UserDatabaseAccess.readUser(context),
                builder:
                    (BuildContext context, AsyncSnapshot<UserRecord> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          const ImageWidget(
                            150,
                            150,
                            avatarImage,
                            imageShape: BoxShape.circle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextStyleWidget(
                            snapshot.data!.fullName,
                            conditionsMessageColor,
                            textSize: 28,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextStyleWidget(
                            snapshot.data!.emailAddress,
                            conditionsMessageColor,
                            textSize: 16,
                          ),
                        ],
                      );
                    }
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: dividerLineColor,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(55, 25, 30, 25),
              child: Wrap(
                runSpacing: 16,
                children: [
                  ListTile(
                    leading: homeIcon,
                    title: const TextStyleWidget(
                      'Home',
                      textMenuColor,
                      textSize: menuMessageSize,
                      textWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      DatePickerWidget.dateValue = DatePickerWidget.getInitialDate();
                      TimePickerWidget.timeValue = TimePickerWidget.getInitialTime();
                      Navigator.of(context).pushReplacementNamed(searchRoute);
                    },
                  ),
                  ListTile(
                    leading: profileIcon,
                    title: const TextStyleWidget(
                      'Profile',
                      textMenuColor,
                      textSize: menuMessageSize,
                      textWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(profileRoute);
                    },
                  ),
                  ListTile(
                    leading: settingsIcon,
                    title: const TextStyleWidget(
                      'Settings',
                      textMenuColor,
                      textSize: menuMessageSize,
                      textWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(settingsRoute);
                    },
                  ),
                  ListTile(
                    leading: exitIcon,
                    title: const TextStyleWidget(
                      'Log Out',
                      textMenuColor,
                      textSize: menuMessageSize,
                      textWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      tryLogOut(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
