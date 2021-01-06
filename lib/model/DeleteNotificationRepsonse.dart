// To parse this JSON data, do
//
//     final deleteNotificationRepsonse = deleteNotificationRepsonseFromJson(jsonString);

import 'dart:convert';

DeleteNotificationRepsonse deleteNotificationRepsonseFromJson(String str) => DeleteNotificationRepsonse.fromJson(json.decode(str));

String deleteNotificationRepsonseToJson(DeleteNotificationRepsonse data) => json.encode(data.toJson());

class DeleteNotificationRepsonse {
  DeleteNotificationRepsonse({
    this.responseCode,
    this.responseMessage,
  });

  int responseCode;
  String responseMessage;

  factory DeleteNotificationRepsonse.fromJson(Map<String, dynamic> json) => DeleteNotificationRepsonse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
  };
}
