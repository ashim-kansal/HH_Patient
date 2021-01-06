// To parse this JSON data, do
//
//     final updateLanguageResponse = updateLanguageResponseFromJson(jsonString);

import 'dart:convert';

UpdateLanguageResponse updateLanguageResponseFromJson(String str) => UpdateLanguageResponse.fromJson(json.decode(str));

String updateLanguageResponseToJson(UpdateLanguageResponse data) => json.encode(data.toJson());

class UpdateLanguageResponse {
  UpdateLanguageResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  Result result;

  factory UpdateLanguageResponse.fromJson(Map<String, dynamic> json) => UpdateLanguageResponse(
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
    this.userType,
    this.appLanguage,
    this.deviceToken,
    this.profilePic,
    this.otpTime,
    this.verifyOtp,
    this.notificationStatus,
    this.programSubscribed,
    this.status,
    this.myTherapist,
    this.myPatient,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.address,
    this.password,
    this.countryCode,
    this.otp,
    this.mergeContact,
    this.permissions,
    this.questions,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.programSubscription,
    this.programId,
  });

  String userType;
  String appLanguage;
  String deviceToken;
  String profilePic;
  int otpTime;
  bool verifyOtp;
  bool notificationStatus;
  bool programSubscribed;
  String status;
  List<String> myTherapist;
  List<dynamic> myPatient;
  String id;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String address;
  String password;
  String countryCode;
  String otp;
  String mergeContact;
  List<dynamic> permissions;
  List<Question> questions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String programSubscription;
  String programId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userType: json["userType"],
    appLanguage: json["appLanguage"],
    deviceToken: json["deviceToken"],
    profilePic: json["profilePic"],
    otpTime: json["otpTime"],
    verifyOtp: json["verifyOtp"],
    notificationStatus: json["notificationStatus"],
    programSubscribed: json["programSubscribed"],
    status: json["status"],
    myTherapist: List<String>.from(json["myTherapist"].map((x) => x)),
    myPatient: List<dynamic>.from(json["myPatient"].map((x) => x)),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    address: json["address"],
    password: json["password"],
    countryCode: json["countryCode"],
    otp: json["otp"],
    mergeContact: json["mergeContact"],
    permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
    questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    programSubscription: json["programSubscription"],
    programId: json["programId"],
  );

  Map<String, dynamic> toJson() => {
    "userType": userType,
    "appLanguage": appLanguage,
    "deviceToken": deviceToken,
    "profilePic": profilePic,
    "otpTime": otpTime,
    "verifyOtp": verifyOtp,
    "notificationStatus": notificationStatus,
    "programSubscribed": programSubscribed,
    "status": status,
    "myTherapist": List<dynamic>.from(myTherapist.map((x) => x)),
    "myPatient": List<dynamic>.from(myPatient.map((x) => x)),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "address": address,
    "password": password,
    "countryCode": countryCode,
    "otp": otp,
    "mergeContact": mergeContact,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "programSubscription": programSubscription,
    "programId": programId,
  };
}

class Question {
  Question({
    this.id,
    this.questionText,
    this.questionType,
    this.options,
    this.questionNumber,
  });

  String id;
  String questionText;
  String questionType;
  List<Option> options;
  String questionNumber;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["_id"],
    questionText: json["QuestionText"],
    questionType: json["QuestionType"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    questionNumber: json["QuestionNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "QuestionText": questionText,
    "QuestionType": questionType,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "QuestionNumber": questionNumber,
  };
}

class Option {
  Option({
    this.answer,
    this.id,
    this.option,
  });

  String answer;
  String id;
  String option;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    answer: json["Answer"],
    id: json["_id"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "Answer": answer,
    "_id": id,
    "option": option,
  };
}
