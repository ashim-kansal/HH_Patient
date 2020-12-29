
import 'dart:io';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/JournalingListModel.dart';
import 'package:flutter_app/model/LibraryModel.dart';
import 'package:flutter_app/model/StaticContentModel.dart';
import 'package:flutter_app/model/UpcomingSessionsModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<LibraryList> getLibraryList() async {
  var token = await GetStringToSP("token");
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
        "token": token
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
        "token": token
      },);
  print(response.body);
  return upcomingSessionFromJson(response.body);
}

Future<JournalingList> getJournalingList() async {
  var token = await GetStringToSP("token");
  final url = HHString.baseURL +"/api/v1/user/journalQuestion_list";
  final response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "token": token
      },);
  print(response.body);
  return journalingListFromJson(response.body);
}