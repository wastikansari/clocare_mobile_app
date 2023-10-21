class OtpModel {
  bool? status;
  Data? data;

  OtpModel({this.status, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? msg;
  int? verificationCode;

  Data({this.msg, this.verificationCode});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    verificationCode = json['verification_code'];
  }
}
