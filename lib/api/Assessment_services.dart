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
        'token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmZDljNmFhOWE1MTJmMzA1OWMwZjI3MSIsImlhdCI6MTYwODU4MDM2MiwiZXhwIjoxNjA4NjY2NzYyfQ.BYFoupiNHeuhaazy7Pb1hVaq2tzwn3F6cdIBUIHTdbA'
      });
  print(response.body);
  return getAssessmentResponseFromJson(response.body);

}
