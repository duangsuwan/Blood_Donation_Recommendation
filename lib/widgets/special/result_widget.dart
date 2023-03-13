import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/widgets/common/card_widget.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class ResultEventWidget extends StatefulWidget {
  const ResultEventWidget({super.key});

  @override
  State<ResultEventWidget> createState() => _ResultEventWidgetState();
}

class _ResultEventWidgetState extends State<ResultEventWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Future<EventRecord?>>?>(
      future: EventDatabaseAccess.readAvailableEvents(context),
      builder: (context, AsyncSnapshot<List<Future<EventRecord?>>?> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleWidget(
                " ${snapshot.data!.length} Blood Donation Event(s)",
                dateTimeColor,
                textSize: 18,
                textWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: eventCardWidthHeight,
                height: eventCardWidthHeight,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, int index) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return FutureBuilder<EventRecord?>(
                        builder:
                            (context, AsyncSnapshot<EventRecord?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Center(child: CardWidget(snapshot.data!));
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
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
