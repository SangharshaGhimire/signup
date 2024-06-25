class RegisterModel {
  String? eventTitle;
  String? teamName;
  String? contact;
  int? noOfPlayers;
  String? address;

  RegisterModel(
      {this.eventTitle,
      this.teamName,
      this.contact,
      this.noOfPlayers,
      this.address});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    eventTitle = json['eventTitle'];
    teamName = json['teamName'];
    contact = json['contact'];
    noOfPlayers = json['noOfPlayers'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventTitle'] = this.eventTitle;
    data['teamName'] = this.teamName;
    data['contact'] = this.contact;
    data['noOfPlayers'] = this.noOfPlayers;
    data['address'] = this.address;
    return data;
  }
}
