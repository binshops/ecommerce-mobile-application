import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/presta_banner.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/models/slide.dart';

class ProductAndCategoryProvider extends ChangeNotifier {
  var _bootStrapState = ViewState.preparing;
  var _categories = <PrestashopCategory>[];
  var _featuredProducts = <Product>[];
  var _categoryProductsState = ViewState.busy;
  var _categoryProducts = <Product>[];
  var slides = <Slide>[];
  var hasMoreCategoryProducts = true;
  var nextPageURL = '';
  var totalNumber = '';
  PrestaBanner prestaBanner;

  ViewState get bootStrapState => _bootStrapState;

  void setBootstrapState(ViewState newState) {
    _bootStrapState = newState;
    notifyListeners();
  }

  void setFirstBootstrapState() {
    _bootStrapState = ViewState.busy;
  }

  List<PrestashopCategory> get categories => _categories;

  void setCategories(List<PrestashopCategory> newCategories) {
    _categories = newCategories;
    notifyListeners();
  }

  List<Product> get topProducts => _featuredProducts;

  void setFeaturedProducts(List<Product> newFeaturedProducts) {
    _featuredProducts = newFeaturedProducts;
  }

  ViewState get getCategoryProductsState => _categoryProductsState;

  void setCategoryProductsState(ViewState newState) {
    _categoryProductsState = newState;
    notifyListeners();
  }

  List<Product> get categoryProducts => _categoryProducts;

  void addCategoryProducts(List<Product> newProducts) {
    _categoryProducts = newProducts;
    notifyListeners();
  }

  void clearCategoryProductsData() {
    _categoryProducts.clear();
    hasMoreCategoryProducts = false;
    nextPageURL = '';
    totalNumber = '';
  }
}
