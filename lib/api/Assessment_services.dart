import 'dart:io';

import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;

String url = HHString.baseURL+"/api/v1/user";

Future<GetAssessmentResponse> getAllAssessments() async {
  final response = await http.get(url+"/get_Assessment_List",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : HHString.token
      });
  print(response.body);
  return getAssessmentResponseFromJson(response.body);

}

Future<GetAssessmentResponse> submitAssessments(result) async {
  final response = await http.post(url+"/submit_AssessmentForm",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : HHString.token
      },
    body:result
  );
  print(response.body);
  return getAssessmentResponseFromJson(response.body);

}
