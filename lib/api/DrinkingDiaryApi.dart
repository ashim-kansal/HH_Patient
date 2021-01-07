import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/GetDrinkingDiaryList.dart';
import 'package:flutter_app/model/GetTherapistsResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/model/AddGoalResponse.dart';

String url = HHString.baseURL+"/api/v1/user";

Future<GetDrinkingDiaryList> getDrinkingDiaryList() async {
  print('hhh');
  var token = await GetStringToSP("token");
  print(token);
  final response = await http.get(url+"/drinkingDairy_details",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      });
  print('actualsixe  '+getDrinkingDiaryListFromJson(response.body).result.length.toString());
  return getDrinkingDiaryListFromJson(response.body);

}

Future<AddGoalResponse> updateDrinkingGoal(goal) async {

  var token = await GetStringToSP("token");
  print(token);
  final response = await http.put(url+"/update_drinkDiary",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'token' : token
      },
      body: jsonEncode(<String, String>{
        "goal": goal.toString()
      })
  );
  print(response.body);
  return addGoalResponseFromJson(response.body);

}
