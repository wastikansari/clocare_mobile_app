class GarmentModel {
  bool? success;
  List<Data>? data;

  GarmentModel({this.success, this.data});

  GarmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }


}

class Data {
  String? id;
  String? text;
  String? image;
  List<ItemsList>? itemsList;

  Data({this.id, this.text, this.image, this.itemsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    image = json['image'];
    if (json['itemsList'] != null) {
      itemsList = <ItemsList>[];
      json['itemsList'].forEach((v) {
        itemsList!.add( ItemsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['image'] = this.image;
    if (this.itemsList != null) {
      data['itemsList'] = this.itemsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsList {
  int? gtypeId;
  String? name;
  String? icon;
  List<Items>? items;

  ItemsList({this.gtypeId, this.name, this.icon, this.items});

  ItemsList.fromJson(Map<String, dynamic> json) {
    gtypeId = json['gtype_id'];
    name = json['name'];
    icon = json['icon'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gtype_id'] = this.gtypeId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? price;
  int? priceId;
  int? subtypeId;
  String? name;
  String? desc;
  String? icon;
  String? description;
  String? defaultPrice;
  int? subServiceId;

  Items(
      {this.price,
      this.priceId,
      this.subtypeId,
      this.name,
      this.desc,
      this.icon,
      this.description,
      this.defaultPrice,
      this.subServiceId});

  Items.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    priceId = json['price_id'];
    subtypeId = json['subtype_id'];
    name = json['name'];
    desc = json['desc'];
    icon = json['icon'];
    description = json['description'];
    defaultPrice = json['default_price'];
    subServiceId = json['sub_service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['price'] = price;
    data['price_id'] = this.priceId;
    data['subtype_id'] = this.subtypeId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['default_price'] = this.defaultPrice;
    data['sub_service_id'] = this.subServiceId;
    return data;
  }
}