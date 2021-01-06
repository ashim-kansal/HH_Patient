import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;



String url = HHString.baseURL+"/api/v1/user";
Future<GetTherapistsResponse> getDrinkingDiaryList() async {

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
