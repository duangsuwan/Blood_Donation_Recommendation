import 'package:blood_donation_recommendation/utilities/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class LocationRecord {
  String junctionId;
  String locationAddress;
  String locationCity;
  String locationState;
  String locationCountry;
  String locationZipCode;
  String locationImageName;

  LocationRecord(
      this.junctionId,
      this.locationAddress,
      this.locationCity,
      this.locationState,
      this.locationCountry,
      this.locationZipCode,
      this.locationImageName);

  static LocationRecord? fromLocationJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data();
    if (json != null) {
      return LocationRecord(
          json['junction id'],
          json['address'],
          json['city'],
          json['state'],
          json['country'],
          json['postal code'],
          json['image name']);
    }
    return null;
  }
}

class LocationDatabaseAccess {
  static Future<LocationRecord?> readEventLocation(
      BuildContext context, String eventLocationId) async {
    try {
      final locationDocument = await FirebaseFirestore.instance
          .collection('Locations')
          .where("junction id", isEqualTo: eventLocationId)
          .get();
      if (locationDocument.docs.isNotEmpty) {
        final locationRecord = locationDocument.docs
            .map((docSnapshot) => LocationRecord.fromLocationJson(docSnapshot))
            .toList()
            .first;
        return locationRecord;
      } else {
        throw const FormatException();
      }
    } on FormatException {
      await showErrorDialog(
        context,
        'Error: Cannot retrieve the location of blood donation event',
      );
    } catch (e) {
      await showErrorDialog(
        context,
        e.toString(),
      );
    }
    return null;
  }

  static Future<String> getLocationImageURL(String locationImageName) async {
    return await FirebaseStorage.instance
        .ref()
        .child("Event_Location_Images/")
        .child(locationImageName)
        .getDownloadURL();
  }
}
