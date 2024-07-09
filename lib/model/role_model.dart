class RoleModel {
  String? email;
  String? firebaseToken;
  int? id;
  String? password;
  String? role;
  String? username;

  RoleModel(
      {this.email,
      this.firebaseToken,
      this.id,
      this.password,
      this.role,
      this.username});

  RoleModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firebaseToken = json['firebase_token'];
    id = json['id'];
    password = json['password'];
    role = json['role'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firebase_token'] = this.firebaseToken;
    data['id'] = this.id;
    data['password'] = this.password;
    data['role'] = this.role;
    data['username'] = this.username;
    return data;
  }
}
