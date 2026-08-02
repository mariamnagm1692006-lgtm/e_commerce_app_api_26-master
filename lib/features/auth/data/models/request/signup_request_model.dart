class SignupRequestModel {
  String? name;
  String? email;
  String? password;

  SignupRequestModel({this.name, this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = "https://i.imgur.com/LDOO4Qs.jpg";
    return data;
  }
}