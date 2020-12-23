// To parse this JSON data, do
//
//     final getBookingSlotsResponse = getBookingSlotsResponseFromJson(jsonString);

import 'dart:convert';

GetBookingSlotsResponse getBookingSlotsResponseFromJson(String str) => GetBookingSlotsResponse.fromJson(json.decode(str));

String getBookingSlotsResponseToJson(GetBookingSlotsResponse data) => json.encode(data.toJson());

class GetBookingSlotsResponse {
  GetBookingSlotsResponse({
    this.responseCode,
    this.responseMessage,
    this.result,
  });

  int responseCode;
  String responseMessage;
  List<Result> result;

  factory GetBookingSlotsResponse.fromJson(Map<String, dynamic> json) => GetBookingSlotsResponse(
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
    this.weekDays,
    this.id,
    this.scheduleDate,
    this.schedule,
    this.therapistId,
    this.isSelected,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  List<WeekDay> weekDays;
  String id;
  DateTime scheduleDate;
  List<Schedule> schedule;
  TherapistId therapistId;
  int v;
  bool isSelected;
  DateTime createdAt;
  DateTime updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    weekDays: List<WeekDay>.from(json["weekDays"].map((x) => weekDayValues.map[x])),
    id: json["_id"],
    scheduleDate: DateTime.parse(json["scheduleDate"]),
    schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
    therapistId: therapistIdValues.map[json["therapistId"]],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    isSelected: false,
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "weekDays": List<dynamic>.from(weekDays.map((x) => weekDayValues.reverse[x])),
    "_id": id,
    "scheduleDate": scheduleDate.toIso8601String(),
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "therapistId": therapistIdValues.reverse[therapistId],
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Schedule {
  Schedule({
    this.status,
    this.id,
    this.startTime,
    this.endTime,
  });

  Status status;
  String id;
  StartTime startTime;
  EndTime endTime;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    status: statusValues.map[json["status"]],
    id: json["_id"],
    startTime: startTimeValues.map[json["startTime"]],
    endTime: endTimeValues.map[json["endTime"]],
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "_id": id,
    "startTime": startTimeValues.reverse[startTime],
    "endTime": endTimeValues.reverse[endTime],
  };
}

enum EndTime { THE_1030, THE_1130, THE_1230, THE_0130, THE_0230, THE_0330, THE_0430, THE_0530, THE_0630 }

final endTimeValues = EnumValues({
  "01:30": EndTime.THE_0130,
  "02:30": EndTime.THE_0230,
  "03:30": EndTime.THE_0330,
  "04:30": EndTime.THE_0430,
  "05:30": EndTime.THE_0530,
  "06:30": EndTime.THE_0630,
  "10:30": EndTime.THE_1030,
  "11:30": EndTime.THE_1130,
  "12:30": EndTime.THE_1230
});

enum StartTime { THE_1000, THE_1100, THE_1200, THE_1300, THE_1400, THE_1500, THE_1600, THE_1700, THE_1800 }

final startTimeValues = EnumValues({
  "10:00": StartTime.THE_1000,
  "11:00": StartTime.THE_1100,
  "12:00": StartTime.THE_1200,
  "13:00": StartTime.THE_1300,
  "14:00": StartTime.THE_1400,
  "15:00": StartTime.THE_1500,
  "16:00": StartTime.THE_1600,
  "17:00": StartTime.THE_1700,
  "18:00": StartTime.THE_1800
});

enum Status { AVAILABLE }

final statusValues = EnumValues({
  "AVAILABLE": Status.AVAILABLE
});

enum TherapistId { THE_5_FE19_CDABC79_D4_C1783_B0714 }

final therapistIdValues = EnumValues({
  "5fe19cdabc79d4c1783b0714": TherapistId.THE_5_FE19_CDABC79_D4_C1783_B0714
});

enum WeekDay { MONDAY, WEDNESDAY, FRIDAY }

final weekDayValues = EnumValues({
  "Friday": WeekDay.FRIDAY,
  "Monday": WeekDay.MONDAY,
  "Wednesday": WeekDay.WEDNESDAY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
