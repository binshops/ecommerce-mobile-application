import 'package:flutter/foundation.dart';
import 'package:prestashop_mobile_app/const_values/urls.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';

class ProductsAndCategoryService {
  static Future<Product> getProductDetails(
      {@required int id, @required WebService webService}) async {
    var response = await webService.getFunction(URLs.productDetail(id));
    if (response.success) {
      return Product.fromJson(response.body['psdata']);
    } else
      return null;
  }

  static Future<bool> fetchCategoryProductList(
      WebService webService,
      String url,
      ProductAndCategoryProvider productAndCategoryProvider,
      String categoryId) async {
    productAndCategoryProvider.setCategoryProductsState(ViewState.busy);

    var products = await successfullyGetProductsAndSetPaginationValues(
        webService, url, productAndCategoryProvider, categoryId);
    if (products != null) {
      productAndCategoryProvider.addCategoryProducts(products);
      productAndCategoryProvider.setCategoryProductsState(ViewState.ready);
      return true;
    } else {
      productAndCategoryProvider.setCategoryProductsState(ViewState.failed);
      return false;
    }
  }

  static Future<List<Product>> successfullyGetProductsAndSetPaginationValues(
      WebService webService,
      String url,
      ProductAndCategoryProvider productAndCategoryProvider,
      String categoryId) async {
    var products = <Product>[];
    var response = await webService.getFunction(url);
    if (response.success) {
      if (response.body['psdata']['products'] is List)
        for (var product in response.body['psdata']['products']) {
          products.add(Product.fromCategoryAPI(product));
        }
      else if (response.body['psdata']['products'] is Map)
        for (var product in response.body['psdata']['products'].values) {
          products.add(Product.fromCategoryAPI(product));
        }
      if ((response.body['psdata']['pagination']['items_shown_to']
              .toString()) !=
          (response.body['psdata']['pagination']['total_items'].toString())) {
        if (!(response.body['psdata']['pagination']['pages'] is List))
          (response.body['psdata']['pagination']['pages'] as Map)
              .forEach((id, page) {
            if (page['type'] == 'next') {
              productAndCategoryProvider.nextPageURL = page['url'];
              productAndCategoryProvider.hasMoreCategoryProducts = true;
              productAndCategoryProvider.totalNumber = response.body['psdata']
                      ['pagination']['total_items']
                  .toString();
            }
          });
        else if (response.body['psdata']['pagination']['pages'] is List) {
          (response.body['psdata']['pagination']['pages'] as List)
              .forEach((res) {
            if (res['type'] == 'next') {
              productAndCategoryProvider.nextPageURL = res['url'];
              productAndCategoryProvider.hasMoreCategoryProducts = true;
              productAndCategoryProvider.totalNumber = response.body['psdata']
                      ['pagination']['total_items']
                  .toString();
            }
          });
        }
      } else {
        productAndCategoryProvider.hasMoreCategoryProducts = false;
        productAndCategoryProvider.totalNumber =
            response.body['psdata']['pagination']['total_items'].toString();
      }

      return products;
    } else
      return null;
  }
}
