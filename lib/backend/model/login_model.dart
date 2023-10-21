class LoginModel {
  bool? status;
  Data? data;

  LoginModel({this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  int? customerId;
  String? name;
  int? mobile;
  String? email;
  String? accessToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.customerId,
      this.name,
      this.mobile,
      this.email,
      this.accessToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'].toString();
    accessToken = json['access_token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
