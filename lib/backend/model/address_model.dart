class AddressModel {
  bool? status;
  List<Data>? data;

  AddressModel({this.status, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? customerId;
  String? addressType;
  String? addressLabel;
  String? flatNo;
  String? street;
  String? landmark;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  int? pincodeId;
  String? pincodeNo;
  String? formatAddress;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.customerId,
      this.addressType,
      this.addressLabel,
      this.flatNo,
      this.street,
      this.landmark,
      this.stateId,
      this.stateName,
      this.cityId,
      this.cityName,
      this.pincodeId,
      this.pincodeNo,
      this.formatAddress,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    addressType = json['address_type'].toString();
    addressLabel = json['address_label'];
    flatNo = json['flat_no'];
    street = json['street'];
    landmark = json['landmark'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    pincodeId = json['pincode_id'];
    pincodeNo = json['pincode_no'];
    formatAddress = json['format_address'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customer_id'] = this.customerId;
    data['address_type'] = this.addressType;
    data['address_label'] = this.addressLabel;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['landmark'] = this.landmark;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['pincode_id'] = this.pincodeId;
    data['pincode_no'] = this.pincodeNo;
    data['format_address'] = this.formatAddress;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
