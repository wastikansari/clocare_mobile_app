class ProfileModel {
  bool? status;
  Data? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  int? mobile;
  bool? mobileVerified;
  String? email;
  bool? emailVerified;
  int? walletBalance;
    int? unpaidBalance;
  int? famillyMember;
  int? orderLimit;
  String? gender;
  String? dob;
  String? profilePic;
  String? accessToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.name,
      this.mobile,
      this.mobileVerified,
      this.email,
      this.emailVerified,
      this.walletBalance,
      this.unpaidBalance,
      this.famillyMember,
      this.orderLimit,
      this.gender,
      this.dob,
      this.profilePic,
      this.accessToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    email = json['email'];
    emailVerified = json['email_verified'];
    walletBalance = json['wallet_balance'];
    unpaidBalance = json['unpaid_balance'];
    famillyMember = json['familly_member'];
    orderLimit = json['order_limit'];
    gender = json['gender'];
    dob = json['dob'];
    profilePic = json['profile_pic'];
    accessToken = json['access_token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['mobile_verified'] = this.mobileVerified;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['wallet_balance'] = this.walletBalance;
    data['familly_member'] = this.famillyMember;
    data['order_limit'] = this.orderLimit;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['profile_pic'] = this.profilePic;
    data['access_token'] = this.accessToken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
