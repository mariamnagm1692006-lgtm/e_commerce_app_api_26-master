class Tokenmodel {
  String? accessToken;
  String? refreshToken;

  Tokenmodel({this.accessToken, this.refreshToken});

  Tokenmodel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
