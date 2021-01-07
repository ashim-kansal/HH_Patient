// To parse this JSON data, do
//
//     final addGoalResponse = addGoalResponseFromJson(jsonString);

import 'dart:convert';

AddGoalResponse addGoalResponseFromJson(String str) => AddGoalResponse.fromJson(json.decode(str));

String addGoalResponseToJson(AddGoalResponse data) => json.encode(data.toJson());

class AddGoalResponse {
  AddGoalResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory AddGoalResponse.fromJson(Map<String, dynamic> json) => AddGoalResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.achivedGoal,
    this.date,
    this.status,
    this.id,
    this.userId,
    this.setGoal,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int achivedGoal;
  DateTime date;
  String status;
  String id;
  String userId;
  int setGoal;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    achivedGoal: json["achivedGoal"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    id: json["_id"],
    userId: json["userId"],
    setGoal: json["setGoal"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "achivedGoal": achivedGoal,
    "date": date.toIso8601String(),
    "status": status,
    "_id": id,
    "userId": userId,
    "setGoal": setGoal,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
