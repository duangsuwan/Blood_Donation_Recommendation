import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/widgets/common/button_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/card_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_date_widget.dart';
import 'package:blood_donation_recommendation/widgets/special/picker_time_widget.dart';
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
    return Padding(
      padding: secondWidgetGroupPadding,
      child: Column(
        children: [
          Row(
            children: const [
              DatePickerWidget(
                " Donation Date",
                14,
                180,
              ),
              SizedBox(
                width: 20,
              ),
              TimePickerWidget(
                " Donation Time",
                14,
                130,
              ),
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
            child: FutureBuilder<List<Future<EventRecord?>>?>(
              future: EventDatabaseAccess.readAvailableEvents(context),
              builder: (context,
                  AsyncSnapshot<List<Future<EventRecord?>>?> snapshot) {
                if (snapshot.hasData) {
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
                                return FutureBuilder<EventRecord?>(
                                  builder: (context,
                                      AsyncSnapshot<EventRecord?> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Center(
                                        child: CardWidget(snapshot.data!),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                  future: snapshot.data![index],
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
