// To parse this JSON data, do
//
//     final getChatUsers = getChatUsersFromJson(jsonString);

import 'dart:convert';

GetChatUsers getChatUsersFromJson(String str) => GetChatUsers.fromJson(json.decode(str));

String getChatUsersToJson(GetChatUsers data) => json.encode(data.toJson());

class GetChatUsers {
  GetChatUsers({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory GetChatUsers.fromJson(Map<String, dynamic> json) => GetChatUsers(
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
    this.receiverId,
    this.message,
    this.userName,
    this.senderId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String status;
  String id;
  ErId receiverId;
  List<Message> message;
  String userName;
  ErId senderId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    id: json["_id"],
    receiverId: json["receiverId"] == null ? null : ErId.fromJson(json["receiverId"]),
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    userName: json["userName"],
    senderId: json["senderId"]  == null ? ErId.fromJson({
      "profilePic": "",
      "_id": "",
      "firstName": "",
      "lastName": ""
      }) : ErId.fromJson(json["senderId"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "receiverId": receiverId == null ? null : receiverId.toJson(),
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
    "userName": userName,
    "senderId": senderId.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Message {
  Message({
    this.id,
    this.message,
    this.senderId,
    this.createdAt,
  });

  String id;
  String message;
  String senderId;
  DateTime createdAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    message: json["message"],
    senderId: json["senderId"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "senderId": senderId,
    "createdAt": createdAt.toIso8601String(),
  };
}


class ErId {
  ErId({
    this.profilePic,
    this.id,
    this.firstName,
    this.lastName,
  });

  String profilePic;
  String id;
  String firstName;
  String lastName;

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    profilePic: json["profilePic"],
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic,
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
  };
}

