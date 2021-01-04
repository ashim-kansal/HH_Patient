// To parse this JSON data, do
//
//     final rescheduleSessionResponse = rescheduleSessionResponseFromJson(jsonString);

import 'dart:convert';

RescheduleSessionResponse rescheduleSessionResponseFromJson(String str) => RescheduleSessionResponse.fromJson(json.decode(str));

String rescheduleSessionResponseToJson(RescheduleSessionResponse data) => json.encode(data.toJson());

class RescheduleSessionResponse {
  RescheduleSessionResponse({
    this.responseCode,
    this.responseMessage,
  });

  int responseCode;
  String responseMessage;

  factory RescheduleSessionResponse.fromJson(Map<String, dynamic> json) => RescheduleSessionResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
  };
}
