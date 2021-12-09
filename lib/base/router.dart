import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/ui/views/main_view.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/cart_screen/cart_screen.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/search_screen/search_results_screen.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/search_screen/search_screen.dart';
import 'package:prestashop_mobile_app/ui/views/product_details_screen/product_details_screen.dart';
import 'package:prestashop_mobile_app/ui/views/products_list_screen/products_list_screen.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.ProductDetailPath:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                  product: product,
                ));
      case RoutePaths.CategoriesListScreenPath:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case RoutePaths.MainViewPath:
        return MaterialPageRoute(builder: (_) => MainView());
      case RoutePaths.CartScreenPath:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case RoutePaths.SearchResultsScreenPath:
        var searchResult = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SearchResultsScreen(result: searchResult));
      case RoutePaths.ProductsListScreen:
        var category = settings.arguments as PrestashopCategory;
        return MaterialPageRoute(
            builder: (_) => ProductsListScreen(category: category));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child:
                        TextView(text: 'No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
