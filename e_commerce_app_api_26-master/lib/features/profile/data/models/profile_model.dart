class ProfileModel {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  ProfileModel({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
  }
}
