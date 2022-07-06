class NotificationModel {
  bool? status;
  String? code;
  dData? data;

  NotificationModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = dData.FromJson(json['data']);
  }
}

class dData {
  // String? message;
  List<notificationData> datalist = []; //data;

  dData.FromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      datalist.add(notificationData.FromJson(element));
    });
  }
}

class notificationData {
  String? notify_id;
  String? notify_type;
  int? notify_type_id;
  String? notify_title;
  String? notify_text;
  bool? notify_reading;
  String? notify_custom_date;
  String? notify_created_at;
  String? notify_updated_at;

  notificationData.FromJson(Map<String, dynamic> json) {
    notify_id = json['notify_id'];
    notify_type = json['notify_type'];
    notify_type_id = json['notify_type_id'];
    notify_title = json['notify_title'];
    notify_text = json['notify_text'];
    notify_reading = json['notify_reading'];
    notify_custom_date = json['notify_custom_date'];
    notify_created_at = json['notify_created_at'];
    notify_updated_at = json['notify_updated_at'];
  }
}
