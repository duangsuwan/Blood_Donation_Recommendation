import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/constants/sizes.dart';
import 'package:blood_donation_recommendation/controllers/datetime_controller.dart';
import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/models/locations.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final EventRecord eventRecord;
  const CardWidget(this.eventRecord, {super.key});

  @override
  Widget build(BuildContext context) {
    String startDateTime =
        DateTimeConverter.getDateTime(eventRecord.startDateTime);
    String finishDateTime =
        DateTimeConverter.getDateTime(eventRecord.finishDateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: eventCardWidth,
        height: eventCardHeight,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: eventDetailCard,
            width: 20,
          ),
          borderRadius: const BorderRadiusDirectional.all(
            Radius.circular(20),
          ),
          color: eventDetailCard,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<LocationRecord?>(
            future: LocationDatabaseAccess.readEventLocation(
                context, eventRecord.eventLocation),
            builder: (context, AsyncSnapshot<LocationRecord?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Row(
                  children: [
                    Container(
                      width: 120,
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<String>(
                        future: LocationDatabaseAccess.getLocationImageURL(
                            snapshot.data!.locationImageName),
                        builder: (context, AsyncSnapshot<String> snapShot) {
                          if (snapShot.connectionState ==
                                  ConnectionState.done &&
                              snapShot.hasData) {
                            return Image.network(
                              snapShot.data!,
                              width: 120,
                              height: 120,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyleWidget(
                            eventRecord.eventName,
                            conditionsMessageColor,
                            textSize: 16,
                            textWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextStyleWidget(
                            " ${snapshot.data!.locationAddress}",
                            conditionsMessageColor,
                            textSize: 10,
                            textWeight: FontWeight.bold,
                          ),
                          TextStyleWidget(
                            " ${snapshot.data!.locationCity} ${snapshot.data!.locationState} ${snapshot.data!.locationZipCode}",
                            conditionsMessageColor,
                            textSize: 10,
                            textWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const TextStyleWidget(
                            " Event Duration",
                            conditionsMessageColor,
                            textSize: 10,
                            textWeight: FontWeight.bold,
                          ),
                          TextStyleWidget(
                            " From $startDateTime",
                            conditionsMessageColor,
                            textSize: 10,
                          ),
                          TextStyleWidget(
                            " To $finishDateTime",
                            conditionsMessageColor,
                            textSize: 10,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: const [
                              TextStyleWidget(
                                " Traffic Level:  ",
                                conditionsMessageColor,
                                textSize: 12,
                                textWeight: FontWeight.bold,
                              ),
                              TextStyleWidget(
                                "N/A",
                                conditionsMessageColor,
                                textSize: 12,
                                textWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
    );
  }
}
