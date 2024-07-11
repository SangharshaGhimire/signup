class Token {
  String? role;
  String? username;
  String? email;
  String? password;
  String? firebaseToken;

  Token(
      {this.role,
      this.username,
      this.email,
      this.password,
      this.firebaseToken});

  Token.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}




// class Token {
//   int? userId;
//   String? password;
//   String? email;
//   String? firebaseToken;
//   Address? address;

//   Token(
//       {this.userId,
//       this.password,
//       this.email,
//       this.firebaseToken,
//       this.address});

//   Token.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     password = json['password'];
//     email = json['email'];
//     firebaseToken = json['firebaseToken'];
//     address =
//         json['address'] != null ? new Address.fromJson(json['address']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['password'] = this.password;
//     data['email'] = this.email;
//     data['firebaseToken'] = this.firebaseToken;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     return data;
//   }
// }

// class Address {
//   int? addressId;
//   String? streetAddress;
//   String? zipCode;
//   String? state;
//   String? city;

//   Address(
//       {this.addressId,
//       this.streetAddress,
//       this.zipCode,
//       this.state,
//       this.city});

//   Address.fromJson(Map<String, dynamic> json) {
//     addressId = json['address_id'];
//     streetAddress = json['streetAddress'];
//     zipCode = json['zip_code'];
//     state = json['state'];
//     city = json['city'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address_id'] = this.addressId;
//     data['streetAddress'] = this.streetAddress;
//     data['zip_code'] = this.zipCode;
//     data['state'] = this.state;
//     data['city'] = this.city;
//     return data;
//   }
// }
