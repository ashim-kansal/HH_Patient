
import 'dart:io';

import 'package:flutter_app/common/SharedPreferences.dart';
import 'package:flutter_app/model/AuthModel.dart';
import 'package:flutter_app/model/CommonModel.dart';
import 'package:flutter_app/model/CountryResponse.dart';
import 'package:flutter_app/model/SettingModel.dart';
import 'package:flutter_app/model/StateModel.dart';
import 'package:flutter_app/model/UserProfileModel.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> loginAPIHandler(String emailInput, String passwordInput, String deviceToken, String voipToken) async {
    final url = HHString.baseURL +"/api/v1/user/login";
    var language = await GetStringToSP("language");

    print(jsonEncode(<String, String>{
      "email": emailInput,
      "password": passwordInput,
      "deviceToken": deviceToken??""
    }));
    
    final response = await http.post(url, 
    headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": emailInput,
        "password": passwordInput,
        "deviceToken": deviceToken??"",
        "appLanguage": language,
        "voipToken": voipToken??""
      })
    );
    
    var res = json.decode(response.body);
    
    if(response.statusCode == 200){
      print("resss "+ response.body);
      // if(res["responseCode"] == 200){
        return LoginResponseModel.fromJson(res);
      // }
    }else {
      throw Exception('Failed to load data!');
    }
  }

  Future<SignupResponseModel> registerApiHandler(String firstname, String lastname, String email, String password, String number, String country, String state, String countrycode) async {
      final url = HHString.baseURL +"/api/v1/user/signUp";
      var language = await GetStringToSP("language");
      var deviceToken = await GetStringToSP("deviceToken");
      var params = {
          "appLanguage": language,
          "firstName": firstname,
          "lastName": lastname,
          "email": email,
          "mobileNumber": number,
          "password": password,
          "deviceToken": deviceToken??"",
          "countryCode": countrycode,
          "state": state,
          "country": country
      };  

      print(params);
      print(language);
     
      final response = await http.post(url, 
      headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "appLanguage": "EN",
          "firstName": firstname,
          "lastName": lastname,
          "email": email,
          "mobileNumber": number,
          "password": password,
          "deviceToken": deviceToken??"",
          "countryCode": countrycode,
          "state": state,
          "country": country
        })
      );
      print(response);
      var res = json.decode(response.body);
      print(res);
      if(response.statusCode == 200){
        return SignupResponseModel.fromJson(json.decode(response.body));
      }else {
        throw Exception('Failed to load data!');
      }
  }

  // forgot password 
  Future<ForgotPasswordModel> forgotPwdApiHanlder(String emailInput) async {
    final url = HHString.baseURL +"/api/v1/user/forgotPassword";
    
    final response = await http.post(url, 
    headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": emailInput,
      })
    );
    
    var res = json.decode(response.body);

    if(response.statusCode == 200){
      return ForgotPasswordModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load data!');
    }
  }

  //Resend OTP API call
  Future<ForgotPasswordModel> resendOTPAPIHandler() async {

    String userID = await GetStringToSP("userID");
    final url = HHString.baseURL +"/api/v1/user/resendOtp";
    
    final response = await http.post(url, 
    headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "userId": userID
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return ForgotPasswordModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load data!');
    }
  }


  // otp verify

   // ignore: missing_return
    Future<FeedbackResponseModel> otpAPIHandler(String otp) async {

      var userid = await GetStringToSP("userId");

      final url = HHString.baseURL +"/api/v1/user/verifyOtp";
      
      final response = await http.post(url, 
      headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "otp": otp,
          "userId": userid
        })
      );
      
      var res = json.decode(response.body);
      if(response.statusCode == 200){
        return FeedbackResponseModel.fromJson(res);
      }else {
        throw Exception('Failed to load data!');
      }
    }

    // reset otp 

    // ignore: missing_return
    Future<ForgotPasswordModel> resetPwdAPIHandler(String password, String cPassword) async {
      var userid = await GetStringToSP("userId");

      var params = {
          "password": password,
          "confirmPassword": cPassword,
          "userId": userid
        };
        print(params);

      final url = HHString.baseURL +"/api/v1/user/resetPassword";
        
      final response = await http.put(url, 
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "password": password,
          "confirmPassword": cPassword,
          "userId": userid
        })
      );
        
      var res = json.decode(response.body);
      print(res);
      if(response.statusCode == 200){
       return ForgotPasswordModel.fromJson(res);
      }else {
        throw Exception('Failed to load data!');
      }
    }
  
  // buy plan API
  Future<CommonResponse> buyPlanAPIHandler(String tokenId, String planId, String amount) async {

    var token = await GetStringToSP("token");

    print(
      jsonEncode(<String, String>{
        "tokenId": tokenId,
        "programId": planId,
        "amount": amount
      })
    );
    final url = HHString.baseURL +"/api/v1/user/payment";  
    final response = await http.post(url, 
    headers: {
      "Content-Type": "application/json",
      "token": token??HHString.token},
      body: jsonEncode(<String, String>{
        "tokenId": tokenId,
        "programId": planId,
        "amount": amount
      })
    );
    
    var res = json.decode(response.body);
    if(response.statusCode == 200){
      return CommonResponse.fromJson(res);
    }else {
      throw Exception('Failed to load data!');
    }
  }
}

 Future<CountryList> getAllCountry() async {

    final url = HHString.baseURL +"/api/v1/user/countryCodeList";
    final response = await http.get(url,
        headers: {
          "Content-Type": 'application/json',
        });
    print("doneee");
    print(response.body);
    return countryListFromJson(response.body);
  }

   Future<StateList> getAllStates(countryname) async {

    final url = HHString.baseURL +"/api/v1/user/countryState_List?name="+countryname;
    // final url = HHString.baseURL +"/api/v1/user/countryState_List";
    final response = await http.get(url,
        headers: {
          "Content-Type": 'application/json',
        });
    print("doneee");
    print(response.body);
    return stateListFromJson(response.body);
  }