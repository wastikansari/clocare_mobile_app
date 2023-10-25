class OrderModel {
  bool? status;
  List<Data>? data;

  OrderModel({this.status, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
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
  String? orderNo;
  String? orderDisplayNo;
  String? orderType;
  int? serviceId;
  int? noOfServic;
  String? serviceName;
  int? items;
  String? itemsList;
  int? amount;
  String? paymentType;
  String? paymentStatus;
  int? rcvdItems;
  int? dlvrdItems;
  String? pickupDate;
  String? pickupTime;
  String? deliveryDate;
  String? deliveryTime;
  String? pickupAddress;
  String? deliveryAddress;
  String? pickupAddressId;
  String? deliveryAddressId;
  int? deliveryAttempts;
  String? paymentMethod;
  String? deliveryCharges;
  String? payOnPickup;
  String? ordStatus;
  String? createdAt;
  String? updatedAt;
  String? garmentsList;

  Data(
      {this.sId,
      this.customerId,
      this.orderNo,
      this.orderDisplayNo,
      this.orderType,
      this.serviceId,
      this.noOfServic,
      this.serviceName,
      this.items,
      this.itemsList,
      this.amount,
      this.paymentType,
      this.paymentStatus,
      this.rcvdItems,
      this.dlvrdItems,
      this.pickupDate,
      this.pickupTime,
      this.deliveryDate,
      this.deliveryTime,
      this.pickupAddress,
      this.deliveryAddress,
      this.pickupAddressId,
      this.deliveryAddressId,
      this.deliveryAttempts,
      this.paymentMethod,
      this.deliveryCharges,
      this.payOnPickup,
      this.ordStatus,
      this.createdAt,
      this.updatedAt,
      this.garmentsList});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    orderNo = json['order_no'];
    orderDisplayNo = json['order_display_no'];
    orderType = json['order_type'];
    serviceId = json['service_id'];
    noOfServic = json['no_of_servic'];
    serviceName = json['service_name'];
    items = json['items'];
    itemsList = json['items_list'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    rcvdItems = json['rcvd_items'];
    dlvrdItems = json['dlvrd_items'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    pickupAddress = json['pickup_address'];
    deliveryAddress = json['delivery_address'];
    pickupAddressId = json['pickup_address_id'];
    deliveryAddressId = json['delivery_address_id'];
    deliveryAttempts = json['delivery_attempts'];
    paymentMethod = json['payment_method'];
    deliveryCharges = json['delivery_charges'];
    payOnPickup = json['pay_on_pickup'];
    ordStatus = json['ord_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    garmentsList = json['garments_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customer_id'] = this.customerId;
    data['order_no'] = this.orderNo;
    data['order_display_no'] = this.orderDisplayNo;
    data['order_type'] = this.orderType;
    data['service_id'] = this.serviceId;
    data['no_of_servic'] = this.noOfServic;
    data['service_name'] = this.serviceName;
    data['items'] = this.items;
    data['items_list'] = this.itemsList;
    data['amount'] = this.amount;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['rcvd_items'] = this.rcvdItems;
    data['dlvrd_items'] = this.dlvrdItems;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    data['pickup_address'] = this.pickupAddress;
    data['delivery_address'] = this.deliveryAddress;
    data['pickup_address_id'] = this.pickupAddressId;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['delivery_attempts'] = this.deliveryAttempts;
    data['payment_method'] = this.paymentMethod;
    data['delivery_charges'] = this.deliveryCharges;
    data['pay_on_pickup'] = this.payOnPickup;
    data['ord_status'] = this.ordStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['garments_list'] = this.garmentsList;
    return data;
  }
}