import 'package:blood_donation_recommendation/models/locations.dart';
import 'package:blood_donation_recommendation/utilities/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRecord {
  String eventId;
  String eventName;
  LocationRecord? eventLocation;
  DateTime startDateTime;
  DateTime finishDateTime;

  EventRecord(this.eventId, this.eventName, this.eventLocation,
      this.startDateTime, this.finishDateTime);

  static Future<EventRecord?> fromEventJson(BuildContext context,
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final json = snapshot.data();
    if (json != null) {
      final locationDetails = await LocationDatabaseAccess.readEventLocation(
          context, json['event location']);
      return EventRecord(json['event id'], json['event name'], locationDetails,
          json['start time'].toDate(), json['finish time'].toDate());
    }
    return null;
  }
}

class EventDatabaseAccess {
  static Future<List<Future<EventRecord?>>?> readAvailableEvents(
      BuildContext context) async {
    try {
      final eventDocument =
          await FirebaseFirestore.instance.collection('Events').get();
      if (eventDocument.docs.isNotEmpty) {
        final eventRecord = eventDocument.docs
            .map((docSnapshot) async =>
                await EventRecord.fromEventJson(context, docSnapshot))
            .toList();
        return eventRecord;
      } else {
        throw const FormatException();
      }
    } on FormatException {
      await showErrorDialog(
        context,
        'Error: Cannot retrieve blood donation event(s)',
      );
    } catch (e) {
      await showErrorDialog(
        context,
        e.toString(),
      );
    }
    return null;
  }
}
