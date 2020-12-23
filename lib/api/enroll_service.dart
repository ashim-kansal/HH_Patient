
import 'package:flutter_app/models/AuthModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<LoginResponseModel> loginAPIHandler(String emailInput, String passwordInput) async {
    final url = HHString.baseURL +"/api/v1/user/login";
    
    final response = await http.post(url, 
    headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": emailInput,
        "password": passwordInput,
        "deviceToken": "test"
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      // if(res["responseCode"] == 200){
        return LoginResponseModel.fromJson(res);
      // }
    }else {
      throw Exception('Failed to load data!');
    }
  }

  // showToast(String message){
  //   Toast.show(message, 
  //   context, 
  //   duration: Toast.LENGTH_LONG, 
  //   gravity:  Toast.BOTTOM);
  // }
}