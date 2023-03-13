import 'package:blood_donation_recommendation/constants/colors.dart';
import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/models/locations.dart';
import 'package:blood_donation_recommendation/widgets/common/textstyle_widget.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final EventRecord eventRecord;
  const CardWidget(this.eventRecord, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 180,
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
        child: Row(children: [
          Container(
            width: 120,
            alignment: Alignment.centerLeft,
            child: FutureBuilder<String>(
                future: LocationDatabaseAccess.getLocationImageURL(
                    eventRecord.eventLocation!.locationImageName),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Image.network(
                      snapshot.data!,
                      width: 120,
                      height: 120,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
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
                  textSize: 18,
                  textWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextStyleWidget(
                  " ${eventRecord.eventLocation!.locationAddress}",
                  conditionsMessageColor,
                  textSize: 12,
                  textWeight: FontWeight.bold,
                ),
                TextStyleWidget(
                  " ${eventRecord.eventLocation!.locationCity} ${eventRecord.eventLocation!.locationState} ${eventRecord.eventLocation!.locationZipCode}",
                  conditionsMessageColor,
                  textSize: 12,
                  textWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextStyleWidget(
                  " Event Duration",
                  conditionsMessageColor,
                  textSize: 12,
                  textWeight: FontWeight.bold,
                ),
                TextStyleWidget(
                  " ${eventRecord.startDateTime.toString()} - ",
                  conditionsMessageColor,
                  textSize: 12,
                ),
                TextStyleWidget(
                  " ${eventRecord.finishDateTime.toString()}",
                  conditionsMessageColor,
                  textSize: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: const [
                    TextStyleWidget(
                      " Traffic Level:  ",
                      conditionsMessageColor,
                      textSize: 14,
                      textWeight: FontWeight.bold,
                    ),
                    TextStyleWidget(
                      "N/A",
                      conditionsMessageColor,
                      textSize: 14,
                      textWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
