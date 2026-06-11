class UploadModel {
  String? originalname;
  String? filename;
  ///ال url بتاع الصوره بعد ما رفعناها
  String? location;

  UploadModel({this.originalname, this.filename, this.location});

  UploadModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    filename = json['filename'];
    location = json['location'];
  }
  
}