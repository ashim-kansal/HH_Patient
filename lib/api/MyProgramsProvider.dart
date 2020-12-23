import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/models/AuthModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  String url = HHString.baseURL+"/api/v1/user/programList";

  Future<GetProgramsResponse> getAllPrograms() async {
    final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmZDljNmFhOWE1MTJmMzA1OWMwZjI3MSIsImlhdCI6MTYwODU4MDM2MiwiZXhwIjoxNjA4NjY2NzYyfQ.BYFoupiNHeuhaazy7Pb1hVaq2tzwn3F6cdIBUIHTdbA'
        });
    print(response.body);
    return getProgramsResponseFromJson(response.body);

  }

