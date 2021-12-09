import 'package:flutter/foundation.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/product.dart';

class SearchProvider extends ChangeNotifier {
  var _searchResults = <Product>[];
  var _searchingState = ViewState.preparing;
  var hasMoreCategoryProducts = true;
  var nextPageURL = '';
  var totalNumber = '';

  List<Product> get searchResults => _searchResults;

  void setSearchResults(List<Product> newResults) {
    _searchResults = [..._searchResults, ...newResults];
    notifyListeners();
  }

  ViewState get searchingState => _searchingState;

  void setSearchingState(ViewState newState) {
    _searchingState = newState;
    notifyListeners();
  }

  void clearSearchProductsData() {
    _searchResults.clear();
    hasMoreCategoryProducts = false;
    nextPageURL = '';
    totalNumber = '';
  }
}
