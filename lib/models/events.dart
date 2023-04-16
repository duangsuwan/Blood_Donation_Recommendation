import 'package:blood_donation_recommendation/controllers/datetime_controller.dart';
import 'package:blood_donation_recommendation/models/traffic_levels.dart';
import 'package:blood_donation_recommendation/utilities/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRecord {
  String eventId;
  String eventName;
  String eventLocation;
  DateTime startDateTime;
  DateTime finishDateTime;
  int trafficLevelId;
  String trafficLevelDescription;

  EventRecord(this.eventId, this.eventName, this.eventLocation,
      this.startDateTime, this.finishDateTime, {this.trafficLevelId = 3, this.trafficLevelDescription = "N/A"});

  static EventRecord? fromEventJson(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data();
    if (json != null) {
      return EventRecord(
          json['event id'],
          json['event name'],
          json['event location'],
          json['start time'].toDate(),
          json['finish time'].toDate());
    }
    return null;
  }
}

class EventDatabaseAccess {
  static Future<List<EventRecord?>?> readAvailableEvents(
      BuildContext context,
      DateTime selectedDate,
      TimeOfDay selectedTime) async {
    try {
      final selectedDateTime =
          DateTimeConverter.combineDateTime(selectedDate, selectedTime);
      final eventDocument = await FirebaseFirestore.instance
          .collection('Events')
          .where("start time", isLessThanOrEqualTo: selectedDateTime)
          .orderBy("start time")
          .get();
      if (eventDocument.docs.isNotEmpty) {
        final eventRecords = eventDocument.docs
            .map((docSnapshot) =>
                EventRecord.fromEventJson(context, docSnapshot))
            .toList();
        eventRecords.removeWhere((element) => (element!.finishDateTime.isBefore(selectedDateTime.toDate())));
        final updatedEventRecords = TrafficLevelPredictionAPI.predictTrafficLevels(eventRecords, selectedDate, selectedTime);
        return updatedEventRecords;
      }
    } catch (e) {
      await showErrorDialog(
        context,
        e.toString(),
      );
    }
    return null;
  }
}
