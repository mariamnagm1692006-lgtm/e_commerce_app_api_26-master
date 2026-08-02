class AvatarModel {
  String? originalname;
  String? filename;
  String? location;

  AvatarModel({this.originalname, this.filename, this.location});

  AvatarModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }

}