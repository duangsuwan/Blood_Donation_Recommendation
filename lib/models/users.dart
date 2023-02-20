
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  String id;
  String fullName;
  String emailAddress;
  FieldValue currentDate;

  UserRecord(this.id, this.fullName, this.emailAddress, this.currentDate);

  Map<String, dynamic> toJson() => {
    'id' : id,
    'full name' : fullName,
    'email address' : emailAddress,
    'created date' : currentDate,
  };
}