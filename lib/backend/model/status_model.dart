class StatusModel {
  bool? status;
  String? msg;

  StatusModel({this.status, this.msg});

  StatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    return data;
  }
}