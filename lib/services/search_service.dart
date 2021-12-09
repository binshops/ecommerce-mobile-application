

import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/providers/search_provider.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';

class SearchService {
  static Future<bool> fetchSearchProductList(
      WebService webService, String url, SearchProvider searchProvider) async {
    searchProvider.setSearchingState(ViewState.busy);
    var products = await successfullyGetProductsAndSetPaginationValues(
        webService, url, searchProvider);
    if (products != null) {
      searchProvider.setSearchResults(products);
      searchProvider.setSearchingState(ViewState.ready);
      return true;
    } else {
      searchProvider.setSearchingState(ViewState.failed);
      return false;
    }
  }

  static Future<List<Product>> successfullyGetProductsAndSetPaginationValues(
      WebService webService, String url, SearchProvider searchProvider) async {
    var products = <Product>[];

    var response = await webService.getFunction(url);
    if (response.success) {
      for (var product in response.body['psdata']['products']) {
        products.add(Product.fromCategoryAPI(product));
      }
      if ((response.body['psdata']['pagination']['items_shown_to']
              .toString()) !=
          (response.body['psdata']['pagination']['total_items'])) {
        if (!(response.body['psdata']['pagination']['pages'] is List))
          (response.body['psdata']['pagination']['pages'] as Map)
              .forEach((id, page) {
            if (page['type'] == 'next') {
              searchProvider.nextPageURL = page['url'];
              searchProvider.hasMoreCategoryProducts = true;
              searchProvider.totalNumber = response.body['psdata']['pagination']
                      ['total_items']
                  .toString();
            }
          });
        else if (response.body['psdata']['pagination']['pages'] is List) {
          (response.body['psdata']['pagination']['pages'] as List)
              .forEach((res) {
            if (res['type'] == 'next') {
              searchProvider.nextPageURL = res['url'];
              searchProvider.hasMoreCategoryProducts = true;
              searchProvider.totalNumber = response.body['psdata']['pagination']
                      ['total_items']
                  .toString();
            }
          });
        }
      } else {
        searchProvider.hasMoreCategoryProducts = false;
        searchProvider.totalNumber =
            response.body['psdata']['pagination']['total_items'].toString();
      }

      return products;
    } else
      return null;
  }
}
