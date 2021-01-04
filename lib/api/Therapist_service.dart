import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetBookingResponse.dart';
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/model/RescheduleSessionResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;

String url = HHString.baseURL+"/api/v1/user";

Future<GetTherapistsResponse> getAllTherapists() async {
  
  var token = await GetStringToSP("token");
  print(token);
  final response = await http.get(url+"/getTherapistList",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print(response.body);
  return getTherapistsResponseFromJson(response.body);

}

Future<GetTherapistsResponse> getAllPhysicians() async {
  var token = await GetStringToSP("token");

  final response = await http.get(url+"/getPhysicianList",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print(response.body);
  return getTherapistsResponseFromJson(response.body);

}

Future<GetBookingSlotsResponse> getSlotsForBooking(String id) async {
  var token = await GetStringToSP("token");

  final response = await http.get(url+"/getSlotFor_booking?userId="+id,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
  });
  print(response.body);
  return getBookingSlotsResponseFromJson(response.body);

}

Future<GetBookingResponse> bookSession(String id) async {
  var token = await GetStringToSP("token");

  final response = await http.post(url+"/bookSession",
      body: jsonEncode(<String, String>{"slotId":id}),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
  });
  print(response.body);
  return getBookingResponseFromJson(response.body);

}

Future<RescheduleSessionResponse> reScheduleSession(String slotId,String sessionId) async {
  var token = await GetStringToSP("token");

  print('token   ' + token);
  print('slotId   ' + slotId);
  print('sessionId   ' + sessionId);

  final response = await http.post(url+"/reschedule_session",
      body: jsonEncode(<String, String>{"slotId":slotId, "sessionId":sessionId}),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print(response.body);
  return rescheduleSessionResponseFromJson(response.body);

}

Future<GetBookingResponse> cancelSession(String sessionId) async {
  var token = await GetStringToSP("token");

  final response = await http.post(url+"/cancelSession",
      body: jsonEncode(<String, String>{"sessionId":sessionId}),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print(response.body);
  return getBookingResponseFromJson(response.body);

}


