class WalletModel {
  bool? status;
  Data? data;

  WalletModel({this.status, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
  int? walletBalance;

  Data({this.walletBalance});

  Data.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_balance'] = walletBalance;
    return data;
  }
}
