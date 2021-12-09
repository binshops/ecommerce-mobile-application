import 'package:prestashop_mobile_app/models/product_related_models.dart';

class Product {
  int productID;
  String name;
  String availableForOrder;
  bool showPrice;
  bool newProducts;
  bool onSaleProducts;
  int quantity;
  String minimalQuantity;
  String allowOutOfStock;
  String discountPercentage;
  String price;
  String discountPrice;
  List<String> images;
  String description;
  String shortDescription;
  List<Option> options = [];
  ProductInfo productInfo;
  List<Combination> combinations = [];
  bool listItem;

  // used to order details
  String reference;
  String totalPrice;

  Product.fromOrderDetails(Map<String, dynamic> json) {
    productID = int.tryParse(json['id_product']);
    name = json['product_name'];
    this.totalPrice = json['total'];
    this.price = json['price'];
    this.reference = json['reference'];
    this.quantity = int.tryParse(json['quantity'].toString());
  }

  Product.fromCategoryAPI(Map<String, dynamic> json) {
    productID = int.tryParse(json['id_product']);
    images = json['cover'] != null ? [json['cover']['url']]
    : [''];
    name = json['name'];
    this.description = '';
    this.discountPercentage = json['discount_percentage_absolute'];
    this.price = json['regular_price'];
    this.discountPrice =
    json['has_discount'] ?'' : '\$' + json['price_amount'].toString();
    this.shortDescription = '';
    this.combinations = [];
    this.quantity = json['quantity'];
  }

  Product.fromJson(Map<String, dynamic> json, {bool isListItem}) {
    listItem = isListItem ?? false;
    RegExp descriptionPattern = new RegExp('>[^\<]{10,}<');
    if (json['description'] != null)
      description =
          descriptionPattern.stringMatch(json['description'] as String);
    if (description != null) {
      description = description.substring(1, description.length - 2);
    } else
      description = '';
    shortDescription = json['description_short'];
    if (shortDescription != null)
      shortDescription = descriptionPattern.stringMatch(shortDescription);
    if (shortDescription != null) {
      shortDescription =
          shortDescription.substring(1, shortDescription.length - 2);
    }
    if (json['id_product'] is String)
      productID = int.tryParse(json['id_product']);
    else
      productID = json['id_product'];
    name = json['name'];
    availableForOrder = json['available_for_order'];
    if (json['show_price'] is bool)
      showPrice = json['show_price'];
    else
      showPrice = json['show_price'] == '1' ? true : false;
    if (json['new_products'] is bool)
      newProducts = json['new_products'];
    else
      newProducts = json['new_products'] == '1' ? true : false;
    if (json['on_sale_products'] is bool)
      onSaleProducts = json['on_sale_products'];
    else
      onSaleProducts = json['on_sale_products'] == '1' ? true : false;
    quantity = json['quantity'];
    minimalQuantity = json['minimal_quantity'];
    allowOutOfStock = json['allow_out_of_stock'];
    if (json['discount_percentage'] is String)
      discountPercentage = json['discount_percentage'];
    else
      discountPercentage = json['discount_percentage'].toString();

    if (json['price'] is String)
      price = json['price'];
    else
      price = json['price'].toString();
    discountPrice = json['discount_price'] ?? '';
    if (json['images'] != null) {
      images = <String>[];
      if (listItem) {
        images.add(json['images'][0]['medium']['url']);
      } else {
        json['images'].forEach((value) {
          images.add(value['src']);
        });
      }
    }
    options = [];
    if (json['options'] != null)
      for (var option in json['options']) {
        options.add(Option.fromJson(option));
      }
    if (json['product_info'] != null) {
      productInfo = ProductInfo.fromJson(json['product_info']);
    }
    if (json['combinations'] != null) {
      for (var combination in json['combinations']) {
        combinations.add(Combination.fromJson(combination));
      }
    } else
      combinations = [];
  }

  int getOptionIDByItemID(int itemID) {
    var optionID;
    this.options.forEach((option) {
      option.items.forEach((item) {
        if (item.id == itemID) {
          optionID = option.id;
        }
      });
    });
    return optionID;
  }

  Map<int, List<Item>> getAvailableItemsForOptionsByAvailableCombinations(
      List<Combination> availableCombinations, String selectedCode) {
    var newAvailableOptions = Map<int, List<Item>>();
    this.options.forEach((option) {
      newAvailableOptions.addAll({option.id: []});
    });
    availableCombinations.forEach((combination) {
      var listOfIDs = parseIDsInCombinationCode(combination.combinationCode);
      listOfIDs.forEach((itemID) {
        var optionID = this.getOptionIDByItemID(itemID);
        newAvailableOptions[optionID].add(getItemByID(optionID, itemID));
      });
    });
    return newAvailableOptions;
  }

  List<int> parseIDsInCombinationCode(String combinationCode) {
    var ids = <int>[];
    var listOfIDs = combinationCode.split('_');
    listOfIDs.forEach((idString) {
      var id = int.tryParse(idString);
      if (id is int) {
        ids.add(id);
      }
    });
    return ids;
  }

  List<Combination> findAvailableCombinations(String selectedCode) {
    var combinations = <Combination>[];
    this.combinations.forEach((combination) {
      //TODO refactor using split
      if ((selectedCode.length <= combination.combinationCode.length)) {
        if (selectedCode.length == combination.combinationCode.length) {
          if (combination.combinationCode == selectedCode)
            combinations.add(combination);
        } else {
          if ((combination.combinationCode.contains("${selectedCode}_")))
            combinations.add(combination);
        }
      }
    });
    return combinations;
  }

  Item getItemByID(int optionID, int itemID) {
    var option = this.options.firstWhere((option) => option.id == optionID);
    return option.items.firstWhere((item) {
      return item.id == itemID;
    });
  }
}
