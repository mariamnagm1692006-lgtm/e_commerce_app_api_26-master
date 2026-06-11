class SignupErrorModel {
  dynamic message;
  int? statusCode;
  String? error;

  SignupErrorModel({this.message, this.statusCode, this.error});

  SignupErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    error = json['error'];
  }


  String getFormattedMessage() {
    if (message is List) {
      return (message as List).join('\n');
    }
    return message?.toString() ?? "Error";
  }
}