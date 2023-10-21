class NumberCheckModel {
  bool? status;
  Data? data;

  NumberCheckModel({this.status, this.data});

  NumberCheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? msg;

  Data({this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
  }
}
