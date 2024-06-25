class Signup {
  String? name;
  String? email;
  String? password;
  String? contactNumber;
  String? id;

  Signup({this.name, this.email, this.password, this.contactNumber, this.id});

  Signup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    contactNumber = json['contact_number'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['contact_number'] = this.contactNumber;
    data['id'] = this.id;
    return data;
  }
}
