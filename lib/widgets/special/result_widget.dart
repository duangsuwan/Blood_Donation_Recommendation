import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/card_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_date_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_time_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/subtitle_widget.dart';
import 'package:flutter/material.dart';

class ResultEventWidget extends StatefulWidget {
  const ResultEventWidget({super.key});

  @override
  State<ResultEventWidget> createState() => _ResultEventWidgetState();
}

class _ResultEventWidgetState extends State<ResultEventWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    DatePickerWidget datePickerWidget =
        const DatePickerWidget(" Donation Date", 14, 180);
    TimePickerWidget timePickerWidget =
        const TimePickerWidget(" Donation Time", 14, 130);
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          Row(
            children: [
              datePickerWidget,
              const SizedBox(
                width: 20,
              ),
              timePickerWidget,
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 150,
            child: ButtonWidget(
              "Search",
              textSize: menuMessageSize,
              textWeight: FontWeight.bold,
              isDisabled: false,
              onPressed: () {
                Navigator.of(context).pushNamed(resultRoute);
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            child: FutureBuilder<List<EventRecord?>?>(
              future: EventDatabaseAccess.readAvailableEvents(
                context,
                datePickerWidget.getDateFromPicker(),
                timePickerWidget.getTimeFromPicker(),
              ),
              builder: (context, AsyncSnapshot<List<EventRecord?>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyleWidget(
                            " ${snapshot.data!.length} Blood Donation Event(s)",
                            dateTimeColor,
                            textSize: 16,
                            textWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: eventCardWidth,
                            height: eventListHeight,
                            child: Scrollbar(
                              thumbVisibility: true,
                              controller: _scrollController,
                              scrollbarOrientation: ScrollbarOrientation.right,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, int index) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Center(
                                      child: CardWidget(snapshot.data![index]!),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SubTitleWidget();
                    }
                  } else {
                    return const SubTitleWidget();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
