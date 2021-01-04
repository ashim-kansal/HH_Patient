
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/SettingModel.dart';
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
    var userId = await GetStringToSP("userId");
    final url = HHString.baseURL +"/api/v1/user/feedback";
    
    final response = await http.post(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token},
      body: jsonEncode(<String, String>{
        "feedback": feedback,
        "sessionId": userId,
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


  Future<CommonResponse> updateProfile(imageFile) async {

    var token = await GetStringToSP("token");

    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    // var length = await imageFile.length;

    print(imageFile.path);
    

    final url = HHString.baseURL +"/api/v1/user/uploadImage";

    Map<String, String> headers = { "token": token??HHString.token};

    // final mimeTypeData = lookupMimeType(imageFile, headerBytes: [0xFF, 0xD8]).split('/');
    
    // print(mimeTypeData);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    final file = http.MultipartFile("image", stream, 10,
          filename: "testImage");

    // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
    request.headers.addAll(headers);

    request.files.add(file);

    try {
      final streamedResponse = await request.send();
      print(streamedResponse.stream);
      print(streamedResponse.request);
      final reqResponse = await http.Response.fromStream(streamedResponse);
      print(json.decode(reqResponse.body));
      if (reqResponse.statusCode != 200) {
        return null;
      }
  
      return CommonResponse.fromJson(json.decode(reqResponse.body));
    } catch (e) {
      print(e);
      return null;
    }

    // final response = await http.post(url, 
    // headers: {
    //   "Content-Type": "application/json",
    //   "token": token??HHString.token},
    //   body: jsonEncode(<String, String>{
    //     "image": imagebase64,
    //   })
    // );
    
    // var res = json.decode(response.body);
    // if(response.statusCode == 200){
    //   return FeedbackResponseModel.fromJson(res);
    // }else {
    //   throw Exception('Failed to load data!');
    // }
  }

}