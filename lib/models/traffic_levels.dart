import 'package:blood_donation_recommendation/models/events.dart';
import 'package:blood_donation_recommendation/constants/messages.dart';
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
  String eventId;
  String junction;
  String year;
  String month;
  String date;
  String dayOfWeek;
  String hour;

  TrafficLevelPredictionBody(this.eventId, this.junction, this.year, this.month, this.date, this.dayOfWeek, this.hour);

  Map<String, dynamic> toTrafficLevelPredictionBodyJson() => {
    'eventId': eventId,
    'junction': junction,
    'year': year,
    'month': month,
    'date': date,
    'dayOfWeek': dayOfWeek,
    'hour': hour
  };
}

class TrafficLevelPredictionResponse {
  final String eventId;
  final String predictedTrafficLevel;

  TrafficLevelPredictionResponse(this.eventId, this.predictedTrafficLevel);

  factory TrafficLevelPredictionResponse.fromTrafficLevelPredictionResponseJson(Map<String, dynamic> data) {
    final eventId = data['eventId'];
    final trafficLevelResult = data['prediction'];
    return TrafficLevelPredictionResponse(eventId, trafficLevelResult);
  }
}

class TrafficLevelPredictionAPI {
  Future<List<EventRecord?>> predictTrafficLevels(List<EventRecord?> eventRecords, DateTime selectedDate, TimeOfDay selectedTime) async {
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
      List<String> apiRequests = [];
      for (int i=0; i<eventRecords.length; i++) {
        String eventId = eventRecords[i]!.eventId;
        String junction = eventRecords[i]!.eventLocation;
        final predictionBody = TrafficLevelPredictionBody(eventId, junction, year, month, date, dayOfWeek, hour); 
        final predictionRequest = TrafficLevelPredictionRequest(predictionBody);
        apiRequests.add(jsonEncode(predictionRequest.toTrafficLevelPredictionRequestJson()));
      }
      TrafficLevelPredictionResponse? trafficLevelPredictionResponse;
      List<TrafficLevelPredictionResponse> trafficLevelPredictionResponses = [];
      await Future.forEach(apiRequests, (apiRequest) async {
        trafficLevelPredictionResponse = await connectWithAPI(apiRequest);
        if (trafficLevelPredictionResponse != null) {
          trafficLevelPredictionResponses.add(trafficLevelPredictionResponse!);
        }
      });
      if (trafficLevelPredictionResponses.isNotEmpty) {
        for (int i=0; i<trafficLevelPredictionResponses.length; i++) {
          for (int j=0; j<eventRecords.length; j++) {
            if (trafficLevelPredictionResponses[i].eventId == eventRecords[j]!.eventId && trafficLevelPredictionResponses[i].predictedTrafficLevel == lightTrafficLevel) {
              eventRecords[j]!.trafficLevelId = 0;
              eventRecords[j]!.trafficLevelDescription = trafficLevelPredictionResponses[i].predictedTrafficLevel;
              break;
            }
            else if (trafficLevelPredictionResponses[i].eventId == eventRecords[j]!.eventId && trafficLevelPredictionResponses[i].predictedTrafficLevel == moderateTrafficLevel) {
              eventRecords[j]!.trafficLevelId = 1;
              eventRecords[j]!.trafficLevelDescription = trafficLevelPredictionResponses[i].predictedTrafficLevel;
              break;
            }
            else if (trafficLevelPredictionResponses[i].eventId == eventRecords[j]!.eventId && trafficLevelPredictionResponses[i].predictedTrafficLevel == heavyTrafficLevel) {
              eventRecords[j]!.trafficLevelId = 2;
              eventRecords[j]!.trafficLevelDescription = trafficLevelPredictionResponses[i].predictedTrafficLevel;
              break;
            }
          }
        }
      }
      if (eventRecords.length > 1) {
        eventRecords.sort(((a, b) => a!.trafficLevelId.compareTo(b!.trafficLevelId)));
      }
    }
    return eventRecords;
  }

  Future<TrafficLevelPredictionResponse?> connectWithAPI(String apiRequest) async {
    final url = Uri.https('bgsfx2a8tl.execute-api.us-east-2.amazonaws.com', '/blooddonationevents/displaytrafficlevels');
    final apiResponse = await http.post(url, body: apiRequest);
    if (apiResponse.statusCode == 200) {
      final trafficLevelPredictionResponse = TrafficLevelPredictionResponse.fromTrafficLevelPredictionResponseJson(json.decode(apiResponse.body));
      return trafficLevelPredictionResponse;
    }
    return null;
  }
}