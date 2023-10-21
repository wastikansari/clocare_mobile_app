class PackageModel {
  bool? status;
  List<Data>? data;

  PackageModel({this.status, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? packageName;
  String? packageCode;
  String? prices;
  String? valid;
  String? freePickup;
  String? freeDelivery;
  String? routineGarments;
  String? ironing;
  String? steamIroning;
  String? washIroning;
  String? dryCleaning;
  String? termConditions;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.packageName,
      this.packageCode,
      this.prices,
      this.valid,
      this.freePickup,
      this.freeDelivery,
      this.routineGarments,
      this.ironing,
      this.steamIroning,
      this.washIroning,
      this.dryCleaning,
      this.termConditions,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    packageName = json['package_name'];
    packageCode = json['package_code'];
    prices = json['prices'];
    valid = json['valid'];
    freePickup = json['free_pickup'];
    freeDelivery = json['free_delivery'];
    routineGarments = json['routine_garments'];
    ironing = json['ironing'];
    steamIroning = json['steam_ironing'];
    washIroning = json['wash_ironing'];
    dryCleaning = json['dry_cleaning'];
    termConditions = json['termConditions'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['package_name'] = packageName;
    data['package_code'] = packageCode;
    data['prices'] = this.prices;
    data['valid'] = this.valid;
    data['free_pickup'] = this.freePickup;
    data['free_delivery'] = this.freeDelivery;
    data['routine_garments'] = this.routineGarments;
    data['ironing'] = this.ironing;
    data['steam_ironing'] = this.steamIroning;
    data['wash_ironing'] = this.washIroning;
    data['dry_cleaning'] = this.dryCleaning;
    data['termConditions'] = this.termConditions;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
