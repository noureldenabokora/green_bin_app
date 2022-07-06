class UserFacebookModel {
  String? email;
  String? id;
  String? name;
  PictureModel? pictureModel;

  UserFacebookModel.FromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'] as String;
    name = json['name'];
    pictureModel = PictureModel.FromJson(json['picture']['data']);
  }

  UserFacebookModel({this.email, this.pictureModel, this.name, this.id});
}

class PictureModel {
  String? url;
  int? widht;
  int? height;

  PictureModel({this.url, this.widht, this.height});

  PictureModel.FromJson(Map<String, dynamic> json) {
    url = json['url'];
    widht = json['widht'];
    height = json['height'];
  }
}
