import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  String url = HHString.baseURL+"/api/v1/user/programList";

  Future<GetProgramsResponse> getAllPrograms() async {
    var token = await GetStringToSP("token");

    final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'token' : token
        });
    print(response.body);
    return getProgramsResponseFromJson(response.body);

  }

