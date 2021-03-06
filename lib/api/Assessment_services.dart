import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetAssessmentResponse.dart';
import 'package:flutter_app/model/SubmitAssessmentResponse.dart';
import 'package:flutter_app/model/SubmittedAssessmentResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;

String url = HHString.baseURL+"/api/v1/user";

Future<GetAssessmentResponse> getAllAssessments() async {

  var token = await GetStringToSP("token");
  final response = await http.get(url+"/get_Assessment_List",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token??HHString.token
      });
  print(response.body);
  return getAssessmentResponseFromJson(response.body);

}

Future<SubmittedAssessmentResponse> getAssessmentForm(formId) async {

  var token = await GetStringToSP("token");
  final response = await http.get(url+"/get_Assessment_details?formId="+formId,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token??HHString.token
      });
  print(response.body);
  return submittedAssessmentResponseFromJson(response.body);

}

Future<SubmittedAssessmentResponse> getSubmittedAssessmentForm(formId) async {
  var token = await GetStringToSP("token");

  final response = await http.get(url+"/view_submitted_assessmentForm?formId="+formId,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token??HHString.token
      });
  print(response.body);
  return submittedAssessmentResponseFromJson(response.body);

}

Future<SubmitAssessmentResponse> submitAssessments(result) async {
  var token = await GetStringToSP("token");

  final response = await http.post(url+"/submit_AssessmentForm",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token??HHString.token
      },
      body:json.encode(result)
  );
  print(response.body);
  return submitAssessmentResponseFromJson(response.body);

}
