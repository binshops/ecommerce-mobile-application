import 'config.dart';

class URLs {
  static const BOOTSTRAP = ENDPOINT + 'bootstrap?menu_with_images=single';

  static String categoryProducts(String id) {
    return ENDPOINT +
        'categoryProducts?id_category=$id&image_size=home_default';
  }

  static String productDetail(int id) {
    return ENDPOINT + 'productdetail?product_id=' + id.toString();
  }

  static String searchUrl(String searchedString) {
    return ENDPOINT + 'productSearch?s=' + searchedString;
  }
}
