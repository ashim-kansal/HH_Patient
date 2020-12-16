// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

LoginModel userModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String userModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String email;
  String password;

  LoginModel({
    this.email,
    this.password
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}