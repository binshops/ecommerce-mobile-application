class Combination {
  int idProductAttribute;
  int quantity;
  String price;
  int minimalQuantity;
  String combinationCode;

  Combination(
      {this.idProductAttribute,
      this.quantity,
      this.price,
      this.minimalQuantity,
      this.combinationCode});

  Combination.fromJson(Map<String, dynamic> json) {
    idProductAttribute = json['id_product_attribute'];
    quantity = json['quantity'];
    price = json['price'];
    minimalQuantity = json['minimal_quantity'];
    combinationCode = json['combination_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product_attribute'] = this.idProductAttribute;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['minimal_quantity'] = this.minimalQuantity;
    data['combination_code'] = this.combinationCode;
    return data;
  }
}

class Images {
  String src;

  Images({this.src});

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    return data;
  }
}

class Option {
  int id;
  String title;
  bool isColorOption;
  List<Item> items;

  Option({this.id, this.title, this.isColorOption, this.items});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isColorOption = json['is_color_option'] == 0 ? false : true;
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_color_option'] = this.isColorOption;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int id;
  String value;

  Item({this.id, this.value});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}

class ProductInfo {
  List<Info> info;

  ProductInfo({this.info});

  ProductInfo.fromJson(var json) {
    if (json != null) {
      info = <Info>[];
      json.forEach((v) {
        info.add(new Info.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['Info'] = this.info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String name;
  String value;

  Info({this.name, this.value});

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
