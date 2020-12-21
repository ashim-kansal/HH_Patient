class LoginResponseModel {
  final String token;
  final String deviceToken;
  final String appLanguage;
  final bool notificationStatus;
  final bool programSubscribed;
  final String id;

  LoginResponseModel({this.token, this.deviceToken, this.appLanguage, this.notificationStatus, this.programSubscribed, this.id});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["result"]["token"]?? "",
      deviceToken: json["result"]["deviceToken"]?? "",
      appLanguage: json["result"]["appLanguage"]?? "",
      notificationStatus: json["result"]["notificationStatus"]?? ""
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

class ForgotPasswordModel {
  final String userid;

  ForgotPasswordModel({this.userid});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json){
    return ForgotPasswordModel(userid: json["result"]?? "");
  }
}

class SignupModel {
  final String response;

  SignupModel({this.response});

  factory SignupModel.fromJson(Map<String, dynamic> json){
    return SignupModel(response: json["result"]?? "");
  }
}