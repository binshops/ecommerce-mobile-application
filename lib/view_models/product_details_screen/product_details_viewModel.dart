import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/models/product_related_models.dart';
import 'package:prestashop_mobile_app/services/products_and_category_service.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsViewModel extends ChangeNotifier {
  ProductDetailsViewModel({Product product}) {
    this._product = product;
  }

  //combination Management Values
  Map<int, Item> _selectedValuesOfOptions = {};

  Map<int, Item> get selectedValuesOfOptions => _selectedValuesOfOptions;
  Map<int, List<Item>> availableItemsForEachOption = {};
  int selectedQuantity = 1;
  int _selectedAttributeID;

  void initializeOptions() {
    if (product.combinations.isNotEmpty) {
      var combinationItems = product.parseIDsInCombinationCode(
          product.combinations.first.combinationCode);
      combinationItems.forEach((itemID) {
        var optionID = product.getOptionIDByItemID(itemID);
        onSelectItem(optionID, product.getItemByID(optionID, itemID));
      });
    }
  }

  void onSelectItem(int optionID, Item selectedItem) {
    var optionIndex =
        product.options.indexWhere((option) => option.id == optionID);
    updateSelectedItemOfOptions(optionID, selectedItem);

    if (product.options.length > 1) {
      bool isLastOptionInList = product.options.length == optionIndex + 1;
      if (!isLastOptionInList) {
        for (int i = optionIndex + 1; i < product.options.length; i++) {
          var selectedCode = getSelectedCodeStringByOptionIndex(optionIndex);
          var availableCombinations =
              product.findAvailableCombinations(selectedCode);
          var newAvailableItems =
              product.getAvailableItemsForOptionsByAvailableCombinations(
                  availableCombinations, selectedCode);
          updateAvailableItems(optionIndex, newAvailableItems);
        }
      }
      setSingleAvailableItemsForOptionsAsSelected();
      var selectedCombinationCode =
          getSelectedCodeStringByOptionIndex(product.options.length - 1);
      var selectedCombinationIndex = product.combinations.indexWhere(
          (combination) =>
              combination.combinationCode == selectedCombinationCode);
      _selectedAttributeID = (selectedCombinationIndex >= 0
          ? product.combinations[selectedCombinationIndex].idProductAttribute
          : -1);
    } else {
      availableItemsForEachOption[product.options.first.id] =
          product.options.first.items;
      var selectedCombinationIndex = product.combinations.indexWhere(
          (combination) =>
              combination.combinationCode == selectedItem.id.toString());
      _selectedAttributeID = (selectedCombinationIndex >= 0
          ? product.combinations[selectedCombinationIndex].idProductAttribute
          : -1);
    }
    selectedQuantity = 1;
    notifyListeners();
  }

  void updateAvailableItems(
      int optionIndex, Map<int, List<Item>> newAvailableItems) {
    for (var i = 0; i < product.options.length; i++) {
      if (i < optionIndex + 1) {
        availableItemsForEachOption[product.options[i].id] =
            product.options[i].items;
      } else {
        availableItemsForEachOption[product.options[i].id] =
            newAvailableItems[product.options[i].id];
        if (newAvailableItems[product.options[i].id].isEmpty) {
          _selectedValuesOfOptions.remove(product.options[i].id);
        }
      }
    }
  }

  void updateSelectedItemOfOptions(int optionID, Item selectedItem) {
    _selectedValuesOfOptions.update(
      optionID,
      (value) => selectedItem,
      ifAbsent: () => selectedItem,
    );
  }

  void setSingleAvailableItemsForOptionsAsSelected() {
    availableItemsForEachOption.forEach((optionID, listOfItems) {
      if (listOfItems.length == 1) {
        updateSelectedItemOfOptions(optionID, listOfItems.first);
      }
    });
  }

  String getSelectedCodeStringByOptionIndex(int index) {
    var codeString = '';
    for (int i = 0; i <= index; i++) {
      var selectedValue = selectedValuesOfOptions[product.options[i].id];
      if (selectedValue != null) codeString += selectedValue.id.toString();
      if (i != index && !codeString.endsWith("_")) {
        codeString += '_';
      }
    }
    if (codeString.endsWith("_")) {
      return codeString.substring(0, codeString.length - 1);
    }
    return codeString;
  }

  void setSelectedQuantity(int newQuantity) {
    selectedQuantity = newQuantity;
    notifyListeners();
  }

  int get selectedAttributeID {
    if (_selectedAttributeID == null) {
      if (product.combinations.isNotEmpty) {
        return product.combinations.first.idProductAttribute;
      } else
        return null;
    } else
      return _selectedAttributeID;
  }

  int getMaxQuantity() {
    if (product.combinations.isEmpty)
      return product.quantity;
    else {
      return product.combinations
          .firstWhere(
              (element) => element.idProductAttribute == selectedAttributeID)
          .quantity;
    }
  }

//product details update
  Product _product;

  Product get product => _product;
  ViewState _fetchingProductDetailsState = ViewState.preparing;

  ViewState get fetchingProductDetailsState => _fetchingProductDetailsState;

  void setFetchingProductDetailsState(ViewState newState) {
    _fetchingProductDetailsState = newState;
    notifyListeners();
  }

  void getProductDetails(WebService webService) async {
    setFetchingProductDetailsState(ViewState.busy);
    var productDetails = await ProductsAndCategoryService.getProductDetails(
        id: product.productID, webService: webService);
    if (productDetails != null) {
      _product = productDetails;
      initializeOptions();
      setFetchingProductDetailsState(ViewState.ready);
    } else {
      setFetchingProductDetailsState(ViewState.failed);
    }
  }
}
