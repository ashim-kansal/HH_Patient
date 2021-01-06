// To parse this JSON data, do
//
//     final notificationListRepsonse = notificationListRepsonseFromJson(jsonString);

import 'dart:convert';

NotificationListRepsonse notificationListRepsonseFromJson(String str) => NotificationListRepsonse.fromJson(json.decode(str));

String notificationListRepsonseToJson(NotificationListRepsonse data) => json.encode(data.toJson());

class NotificationListRepsonse {
  NotificationListRepsonse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory NotificationListRepsonse.fromJson(Map<String, dynamic> json) => NotificationListRepsonse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.status,
    this.id,
    this.userId,
    this.title,
    this.body,
    this.sentBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String status;
  String id;
  String userId;
  String title;
  String body;
  String sentBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    body: json["body"],
    sentBy: json["sentBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "userId": userId,
    "title": title,
    "body": body,
    "sentBy": sentBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
