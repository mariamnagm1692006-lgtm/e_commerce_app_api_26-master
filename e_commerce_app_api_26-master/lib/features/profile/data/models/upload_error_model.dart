class UploadErrorModel {
  int? statusCode;
  String? message;

  UploadErrorModel({this.statusCode, this.message});

  UploadErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
}