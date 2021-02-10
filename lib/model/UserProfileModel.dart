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
        this.totalUnreadNotificationList,
    });

    int responseCode;
    String responseMessage;
    UserData result;
    int totalUnreadNotificationList;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        result: UserData.fromJson(json["userData"]),
        totalUnreadNotificationList: json["totalUnreadNotificationList"],
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "userData": result.toJson(),
        "totalUnreadNotificationList": totalUnreadNotificationList,
    };
}

class UserData {
    UserData({
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
        this.mobileNumber,
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
        this.address,
    });

    String userType;
    String appLanguage;
    String deviceToken;
    String voipToken;
    String profilePic;
    int otpTime;
    bool verifyOtp;
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
    String mobileNumber;
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
    String address;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        mobileNumber: json["mobileNumber"],
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
        address: json["address"],
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
        "mobileNumber": mobileNumber,
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
        "address": address,
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
