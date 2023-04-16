import 'package:blood_donation_recommendation/models/events.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrafficLevelPredictionRequest {
  TrafficLevelPredictionBody trafficLevelPredictionBody;

  TrafficLevelPredictionRequest(this.trafficLevelPredictionBody);

  Map<String, dynamic> toTrafficLevelPredictionRequestJson() => {
    'Blood_Donation_Event': trafficLevelPredictionBody.toTrafficLevelPredictionBodyJson()
  };
}

class TrafficLevelPredictionBody {
  String junction;
  String year;
  String month;
  String date;
  String dayOfWeek;
  String hour;

  TrafficLevelPredictionBody(this.junction, this.year, this.month, this.date, this.dayOfWeek, this.hour);

  Map<String, dynamic> toTrafficLevelPredictionBodyJson() => {
    'junction': junction,
    'year': year,
    'month': month,
    'date': date,
    'dayOfWeek': dayOfWeek,
    'hour': hour
  };
}

class TrafficLevelPredictionResponse {
  final String predictedTrafficLevel;

  TrafficLevelPredictionResponse(this.predictedTrafficLevel);

  factory TrafficLevelPredictionResponse.fromTrafficLevelPredictionResponseJson(Map<String, dynamic> data) {
    final trafficLevelResult = data['prediction'];
    return TrafficLevelPredictionResponse(trafficLevelResult);
  }
}

class TrafficLevelPredictionAPI {
  static Future<List<EventRecord?>> predictTrafficLevels(List<EventRecord?> eventRecords, DateTime selectedDate, TimeOfDay selectedTime) async {
    if (eventRecords.isNotEmpty) {
      String year = (selectedDate.year).toString();
      String month = (selectedDate.month).toString();
      String date = (selectedDate.day).toString();
      String dayOfWeek = (selectedDate.weekday - 1).toString();
      int selectedHour = selectedTime.hour;
      if (selectedTime.minute > 30) {
        selectedHour = selectedHour + 1;
      }
      String hour = (selectedHour).toString();
      for (int i=0; i < eventRecords.length; i++) {
        String junction = eventRecords[i]!.eventLocation;
        final predictionBody = TrafficLevelPredictionBody(junction, year, month, date, dayOfWeek, hour); 
        final predictionRequest = TrafficLevelPredictionRequest(predictionBody);
        String apiRequest = jsonEncode(predictionRequest.toTrafficLevelPredictionRequestJson());
        final url = Uri.https('bgsfx2a8tl.execute-api.us-east-2.amazonaws.com', '/blooddonationevents/displaytrafficlevels');
        final apiResponse = await http.post(url, body: apiRequest);
        if (apiResponse.statusCode == 200) {
          final trafficLevelPredictionResponse = TrafficLevelPredictionResponse.fromTrafficLevelPredictionResponseJson(json.decode(apiResponse.body));
          eventRecords[i]!.trafficLevel = trafficLevelPredictionResponse.predictedTrafficLevel;
        }
      }
    }
    return eventRecords;
  }
}