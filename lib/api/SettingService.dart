
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/SettingModel.dart';
import 'package:flutter_app/model/UpdateLanguageResponse.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:async/async.dart';
// import 'package:stripe_payment/stripe_payment.dart';

import 'package:mime/mime.dart';

class SettingAPIService {
  Future<FeedbackResponseModel> submitFeedback(String feedback) async {

    var token = await GetStringToSP("token");
    // var userId = await GetStringToSP("userId");
    final url = HHString.baseURL +"/api/v1/user/query";
    
    final response = await http.post(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "query": feedback,
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return FeedbackResponseModel.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }


  // forgot password 
  Future<FeedbackResponseModel> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final url = HHString.baseURL +"/api/v1/user/changePassword";
    var token = await GetStringToSP("token");
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token
    },
      body: jsonEncode(<String, String>{
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      })
    );

    print(response.body);
    var res = json.decode(response.body);


    if(response.statusCode == 200){
      if(res["responseCode"] == 200){
        return FeedbackResponseModel.fromJson(json.decode(response.body));
      }
    }else {
      throw Exception('Failed to load data!');
    }
  }

  // chnage notification status 

  Future<UserProfile> updateNotificationStatus(bool value) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/user/setNotification";
    
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, bool>{
        "notificationStatus": value,
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }

  // Change Language

  Future<UserProfile> changeLanguage(String value) async {

    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/user/setNotification";
    
    final response = await http.put(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "appLanguage": value,
      })
    );
  
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return UserProfile.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UpdateLanguageResponse> UpdateLanguage(langType) async {
    var token = await GetStringToSP("token");
    print(token);
    final url = HHString.baseURL +"/api/v1/user/changeLanguage";
    print(url);
    final response = await http.put(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "token": token
        },
        body: jsonEncode({
          "appLanguage": langType
        }));

    print(response.body);
    return updateLanguageResponseFromJson(response.body);
  }

  Future<Map<String, dynamic>> uploadImageFile({File file})async{
    ///MultiPart request
    var token = await GetStringToSP("token");
    final url = HHString.baseURL +"/api/v1/user/uploadImage";

    var request = http.MultipartRequest(
      'POST', Uri.parse(url),
    );
    Map<String,String> headers={
      "token":token,
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split("/").last,
        // contentType: MediaType('image','jpeg'),
      ),
    );
    request.headers.addAll(headers);
    print("request: "+request.toString());
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    Map<String, dynamic> data = json.decode(response.body);
    print(response.body);
    return data;
  }

}