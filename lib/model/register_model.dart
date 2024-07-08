List<RegisterModel> registerModelFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => RegisterModel.fromJson(json)).toList();
}

class RegisterModel {
  String? eventTitle;
  String? teamName;
  String? contact;
  int? noOfPlayers;
  String? address;
  String? id;

  RegisterModel(
      {this.eventTitle,
      this.teamName,
      this.contact,
      this.noOfPlayers,
      this.address,
      this.id});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    eventTitle = json['eventTitle'];
    teamName = json['teamName'];
    contact = json['contact'];
    noOfPlayers = json['noOfPlayers'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventTitle'] = this.eventTitle;
    data['teamName'] = this.teamName;
    data['contact'] = this.contact;
    data['noOfPlayers'] = this.noOfPlayers;
    data['address'] = this.address;
    data['id'] = this.id;
    return data;
  }
}
