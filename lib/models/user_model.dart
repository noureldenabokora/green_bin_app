class userModel {
  late bool status;

  late String code;
  late iddata data;
  userModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = (json['data'] != null ? iddata.FromJson(json['data']) : null)!;
  }
}

class iddata {
  int? user_id;
  String? message;
  userdata? data;

  iddata.FromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    message = json['message'];
    data = (json['data'] != null ? userdata.FromJson(json['data']) : null);
  }
}

class userdata {
  int? user_id;
  String? user_image;
  String? user_name;
  String? user_email;
  String? user_mobile;
  String? user_birth_date;
  String? user_gender;
  String? user_points;
  String? user_api_token;
  String? user_firebase_token;

  userdata.FromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    user_image = json['user_image'];
    user_name = json['user_name'];
    user_email = json['user_email'];
    user_mobile = json['user_mobile'];
    user_birth_date = json['user_birth_date'];
    user_gender = json['user_gender'];
    user_points = json['user_points'];
    user_api_token = json['user_api_token'];
    user_firebase_token = json['user_firebase_token'];
  }
}
