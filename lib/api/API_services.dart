
import 'dart:io';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/ChatList.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/GetTokenResponse.dart';
import 'package:flutter_app/model/JournalingListModel.dart';
import 'package:flutter_app/model/LibraryModel.dart';
import 'package:flutter_app/model/OldJournalingLisrModel.dart';
import 'package:flutter_app/model/QuestionarieModel.dart';
import 'package:flutter_app/model/ReviewResponse.dart';
import 'package:flutter_app/model/SendMessageResponse.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/model/SubmitQuestionaireResponse.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/model/UpdateLanguageResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<LibraryList> getLibraryList() async {
  var token = await GetStringToSP("token");
  print(token);
  final url = HHString.baseURL +"/api/v1/user/library_list";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },);
  print(response.body);
  return libraryListFromJson(response.body);
}

Future<UpcomingSession> upcomingSessions() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/user/upcomingSessionList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  print(response.body);
  return upcomingSessionFromJson(response.body);
}

Future<UpcomingSession> completedSessoins() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/user/completedSessionList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token?? HHString.token
      },);
  print(response.body);
  return upcomingSessionFromJson(response.body);
}

Future<JournalingList> getJournalingList() async {
  var token = await GetStringToSP("token");
  print(token);
  final url = HHString.baseURL +"/api/v1/user/journalQuestion_list";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token??HHString.token
      },);
  return journalingListFromJson(response.body);
}

// fetch old journal 
Future<OldJournalingList> getOldJournalingList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/user/old_journalList";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token?? HHString.token
      },);
  return oldJournalingListFromJson(response.body);
}

// fetch old journal 
Future<QuestionarieList> getQuestionaire(programId) async {
  var token = await GetStringToSP("token");

  print(token);
  print(programId);

  final url = HHString.baseURL +"/api/v1/user/getQuestionnaire?programId="+programId;
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token?? HHString.token
      },);

  print(response.body);
  return questionarieListFromJson(response.body);
}

// submit questionaire
Future<SubmitQuestionaireResponse> submitQuestionaire(result) async {
  var token = await GetStringToSP("token");
  print(json.encode(result));
  final url = HHString.baseURL +"/api/v1/user/fillQuestionnaire_form";
  final response = await http.put(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },
  body: json.encode(result));
  return submitQuestionaireResponseFromJson(response.body);
}
// fetch drinkingDairy_details
Future<QuestionarieList> getdrinkingDairyDetails() async {
  var token = await GetStringToSP("token");

  final url = HHString.baseURL +"/api/v1/user/drinkingDairy_details";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },);
  return questionarieListFromJson(response.body);
}

Future<GetTokenResponse> getTwilioToken(roomName, identity, reciverId,programName) async {
  var token = await GetStringToSP("token");
  print(token);
  print(roomName);
  print(identity);
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"/api/v1/video/tokenGenerate?user="+identity+"&room="+roomName;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}


Future<GetTokenResponse> createCall(sessionId, reciverId) async {
  var token = await GetStringToSP("token");
  print(token);
  print(sessionId);
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"/api/v1/video/createCall?receiverId="+reciverId+"&room=room_"+sessionId+"&sessionId="+sessionId;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}

Future<GetTokenResponse> callConnected(reciverId, status) async {
  print("rc  : "+reciverId);
  final url = HHString.baseURL +"/api/v1/video/CallConnected?receiverId="+reciverId+"status="+status;
  print(url);
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

  print(response.body);
  return getTokenResponseFromJson(response.body);
}

Future<ReviewResponse> submitSessionReview(sessionId, comments) async {
  var token = await GetStringToSP("token");
  print(token);
  print(sessionId);
  print(comments);
  final url = HHString.baseURL +"/api/v1/user/feedback";
  print(url);
  final response = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },
      body:  jsonEncode({
        "sessionId": sessionId,
        "feedback": comments,
      })
  );

  print(response.body);
  return reviewResponseFromJson(response.body);
}



class InAppAPIServices {
  Future<CommonResponse> submitJournal(params) async {
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/user/fill_journal";
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token" : token?? HHString.token
        },
        body:  jsonEncode({
          "Questions": params})
      );
    if(response.statusCode == 200){
      return CommonResponse.fromJson(json.decode(response.body));
    }else {
        throw Exception('Failed to load data!');
      }
  }

  Future<SendMessageResponse> sendMessage(receiverId, msg) async {
    var token = await GetStringToSP("token");
    print(token);
    final url = HHString.baseURL +"/api/v1/chat/chatAPI";
    print(url);
    print(receiverId);

    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token
        },
        body: jsonEncode({
          "receiverId": receiverId,
          "message": msg
        }));
    print(response.body);

    return sendMessageResponseFromJson(response.body);
  }


}