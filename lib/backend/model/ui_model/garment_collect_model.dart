class Item {
  final String? serviceId;
  final String? serviceName;
  final String? serviceIcon;
  final int? gtypeId;
  final String? gtypeName;
  final String? gtypeIcon;
  final String? itemPrice;
  final String? itemName;
  final String? itemIcon;
  final int? itemQty;

  Item({
    this.serviceId,
    this.serviceName,
    this.serviceIcon,
    this.gtypeId,
    this.gtypeName,
    this.gtypeIcon,
    this.itemPrice,
    this.itemName,
    this.itemIcon,
    this.itemQty,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      serviceId: json['service_id'],
      serviceName: json['service_name'],
      serviceIcon: json['service_icon'],
      gtypeId: json['gtype_id'],
      gtypeName: json['gtype_name'],
      gtypeIcon: json['gtype_icon'],
      itemPrice: json['item_price'],
      itemName: json['item_name'],
      itemIcon: json['item_icon'],
      itemQty: json['item_qty'],
    );
  }
}
