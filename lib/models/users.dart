import 'package:blood_donation_recommendation/utilities/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRecord {
  String userId;
  String fullName;
  String emailAddress;
  FieldValue? currentDate;

  UserRecord(this.userId, this.fullName, this.emailAddress, {this.currentDate});

  Map<String, dynamic> toJson() => {
        'user id': userId,
        'full name': fullName,
        'email address': emailAddress,
        'created date': currentDate,
      };

  static UserRecord? fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final json = snapshot.data();
    if (json != null) {
      return UserRecord(json['user id'], json['full name'],
          json['email address']);
    }
    return null;
  }
}

class DatabaseAccess {
  static void createUser(NavigatorState state, String userId, String fullName,
      String emailAddress) async {
    try {
      final userDocument = FirebaseFirestore.instance.collection("Users").doc();
      final userData = UserRecord(
        userId,
        fullName,
        emailAddress,
        currentDate: FieldValue.serverTimestamp(),
      ).toJson();
      await userDocument.set(userData);
    } catch (e) {
      await showErrorDialog(
        state.context,
        e.toString(),
      );
    }
  }

  static Future<UserRecord> readUser(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDocument = await FirebaseFirestore.instance
            .collection('Users')
            .where("user id", isEqualTo: currentUser.uid)
            .get();
        if (userDocument.docs.isNotEmpty) {
          final userRecord = userDocument.docs
              .map((docSnapshot) => UserRecord.fromJson(docSnapshot))
              .toList().first;
          if (userRecord != null) {
            return userRecord;
          }
        }
      }
      else {
        throw const FormatException();
      }
    } on FormatException {
      await showErrorDialog(
        context,
        'Error: Cannot retrieve current user id',
      ); 
    } catch (e) {
      await showErrorDialog(
        context,
        e.toString(),
      );
    }
    return UserRecord("", "Name", "aaa@xxxx.com");
  }
}