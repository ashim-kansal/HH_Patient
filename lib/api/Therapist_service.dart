import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
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
  final response = await http.get(url+"/getPhysicianList",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmZDljNmFhOWE1MTJmMzA1OWMwZjI3MSIsImlhdCI6MTYwODU4MDM2MiwiZXhwIjoxNjA4NjY2NzYyfQ.BYFoupiNHeuhaazy7Pb1hVaq2tzwn3F6cdIBUIHTdbA'
      });
  print(response.body);
  return getTherapistsResponseFromJson(response.body);

}

Future<GetBookingSlotsResponse> getSlotsForBooking(String id) async {
  final response = await http.get(url+"/getSlotFor_booking?userId="+id,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmZDljNmFhOWE1MTJmMzA1OWMwZjI3MSIsImlhdCI6MTYwODU4MDM2MiwiZXhwIjoxNjA4NjY2NzYyfQ.BYFoupiNHeuhaazy7Pb1hVaq2tzwn3F6cdIBUIHTdbA'
      });
  print(response.body);
  return getBookingSlotsResponseFromJson(response.body);

}
