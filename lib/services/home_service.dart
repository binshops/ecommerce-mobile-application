import 'package:prestashop_mobile_app/const_values/urls.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/presta_banner.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/models/slide.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/services/authentication_service.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';

class HomeService {
  static Future<void> fetchBootStrapData(
      WebService webService,
      AuthenticationService authenticationService,
      ProductAndCategoryProvider productAndCategoryProvider) async {
    var response = await webService.getFunction(
      URLs.BOOTSTRAP,
    );
    if (response.success) {
      var categories = <PrestashopCategory>[];
      var featuredProducts = <Product>[];
      var slides = <Slide>[];

      print('successfully fetched bootstrap');
      for (var menuItem in response.body['psdata']['menuItems']) {
        if (menuItem['type'] == 'category') {
          categories.add(PrestashopCategory.fromJson(menuItem));
        }
      }
      productAndCategoryProvider.setCategories(categories);
      for (var featuredProduct in response.body['psdata']
          ['featuredProductsList']) {
        var product = Product.fromJson(featuredProduct, isListItem: true);
        product.images = [];
        product.images.add(featuredProduct['default_image']['url']);
        featuredProducts.add(product);
      }
      productAndCategoryProvider.setFeaturedProducts(featuredProducts);
      for (var slide in response.body['psdata']['slides']) {
        slides.add(Slide.fromJson(slide));
      }
      productAndCategoryProvider.slides = slides;
      if (response.body['psdata']['banner'] != null) {
        productAndCategoryProvider.prestaBanner =
            PrestaBanner.fromJson(response.body['psdata']['banner']);
      }
      productAndCategoryProvider.setBootstrapState(ViewState.ready);
    }
  }
}
