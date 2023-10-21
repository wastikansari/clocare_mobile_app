class TransactionModel {
  bool? status;
  Data? data;

  TransactionModel({this.status, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
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
  List<Customer>? customer;

  Data({this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['customer'] != null) {
      customer = <Customer>[];
      json['customer'].forEach((v) {
        customer!.add(Customer.fromJson(v));
      });
    }
  }

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? sId;
  String? customerId;
  int? amount;
  String? transactionId;
  String? transactionType;
  String? paymentGatewayResporse;
  String? amountCreditReason;
  String? amountDebitReason;
  String? message;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? timestamp;

  Customer(
      {this.sId,
      this.customerId,
      this.amount,
      this.transactionId,
      this.transactionType,
      this.paymentGatewayResporse,
      this.amountCreditReason,
      this.amountDebitReason,
      this.message,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.timestamp});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'];
    amount = json['amount'];
    transactionId = json['transaction_id'];
    transactionType = json['transaction_type'];
    paymentGatewayResporse = json['payment_gateway_resporse'];
    amountCreditReason = json['amount_credit_reason'];
    amountDebitReason = json['amount_debit_reason'];
    message = json['message'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customer_id'] = customerId;
    data['amount'] = amount;
    data['transaction_id'] = transactionId;
    data['transaction_type'] = transactionType;
    data['payment_gateway_resporse'] = paymentGatewayResporse;
    data['amount_credit_reason'] = amountCreditReason;
    data['amount_debit_reason'] = amountDebitReason;
    data['message'] = message;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['timestamp'] = timestamp;
    return data;
  }
}
