class RegistrationModel {
  bool? status;
  Data? data;

  RegistrationModel({this.status, this.data});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? customerId;
  String? name;
  int? mobile;
  String? email;
  String? accessToken;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.customerId,
      this.name,
      this.mobile,
      this.email,
      this.accessToken,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    accessToken = json['access_token'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
