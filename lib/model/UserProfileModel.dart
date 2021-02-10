// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        this.responseCode,
        this.responseMessage,
        this.result,
    });

    int responseCode;
    String responseMessage;
    Result result;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
        this.voipToken,
        this.profilePic,
        this.otpTime,
        this.verifyOtp,
        this.notificationStatus,
        this.programSubscribed,
        this.isQuestionnaireFilled,
        this.totalSession,
        this.status,
        this.myTherapist,
        this.myPatient,
        this.assignedPrograms,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.countryCode,
        this.mobileNumber,
        this.address,
        this.password,
        this.otp,
        this.mergeContact,
        this.permissions,
        this.questions,
        this.programSubscription,
        this.totalUnreadNotificationList,
    });

    String userType;
    String appLanguage;
    String deviceToken;
    String voipToken;
    String profilePic;
    int otpTime;
    int verifyOtp;
    bool notificationStatus;
    bool programSubscribed;
    bool isQuestionnaireFilled;
    int totalSession;
    String status;
    List<String> myTherapist;
    List<dynamic> myPatient;
    List<dynamic> assignedPrograms;
    String id;
    String firstName;
    String lastName;
    String email;
    String countryCode;
    String mobileNumber;
    String address;
    String password;
    String otp;
    String mergeContact;
    List<dynamic> permissions;
    List<Question> questions;
    String programSubscription;
    int totalUnreadNotificationList;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        userType: json["userType"],
        appLanguage: json["appLanguage"],
        deviceToken: json["deviceToken"],
        voipToken: json["voipToken"],
        profilePic: json["profilePic"],
        otpTime: json["otpTime"],
        verifyOtp: json["verifyOtp"],
        notificationStatus: json["notificationStatus"],
        programSubscribed: json["programSubscribed"],
        isQuestionnaireFilled: json["isQuestionnaireFilled"],
        totalSession: json["totalSession"],
        status: json["status"],
        myTherapist: List<String>.from(json["myTherapist"].map((x) => x)),
        myPatient: List<dynamic>.from(json["myPatient"].map((x) => x)),
        assignedPrograms: List<dynamic>.from(json["assignedPrograms"].map((x) => x)),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        countryCode: json["countryCode"],
        mobileNumber: json["mobileNumber"],
        address: json["address"],
        password: json["password"],
        otp: json["otp"],
        mergeContact: json["mergeContact"],
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
        questions: List<Question>.from(json["Questions"].map((x) => Question.fromJson(x))),
        programSubscription: json["programSubscription"],
        totalUnreadNotificationList: json["totalUnreadNotificationList"],
    );

    Map<String, dynamic> toJson() => {
        "userType": userType,
        "appLanguage": appLanguage,
        "deviceToken": deviceToken,
        "voipToken": voipToken,
        "profilePic": profilePic,
        "otpTime": otpTime,
        "verifyOtp": verifyOtp,
        "notificationStatus": notificationStatus,
        "programSubscribed": programSubscribed,
        "isQuestionnaireFilled": isQuestionnaireFilled,
        "totalSession": totalSession,
        "status": status,
        "myTherapist": List<dynamic>.from(myTherapist.map((x) => x)),
        "myPatient": List<dynamic>.from(myPatient.map((x) => x)),
        "assignedPrograms": List<dynamic>.from(assignedPrograms.map((x) => x)),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        "address": address,
        "password": password,
        "otp": otp,
        "mergeContact": mergeContact,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "Questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "programSubscription": programSubscription,
        "totalUnreadNotificationList": totalUnreadNotificationList,
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
