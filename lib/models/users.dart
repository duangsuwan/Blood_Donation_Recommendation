import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  String userId;
  String fullName;
  String emailAddress;
  FieldValue currentDate;

  UserRecord(this.userId, this.fullName, this.emailAddress, this.currentDate);

  Map<String, dynamic> toJson() => {
    'user id' : userId,
    'full name' : fullName,
    'email address' : emailAddress,
    'created date' : currentDate,
  };
}