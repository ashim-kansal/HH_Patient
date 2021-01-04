// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'dart:convert';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
  FaqResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
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
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String status;
  String id;
  String question;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "question": question,
    "answer": answer,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}




