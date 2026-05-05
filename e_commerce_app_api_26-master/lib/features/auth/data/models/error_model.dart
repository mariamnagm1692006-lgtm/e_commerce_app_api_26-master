class ErrorToken {
  String? message;
  int? statusCode;

  ErrorToken({this.message, this.statusCode});

  ErrorToken.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

}

