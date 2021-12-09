import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/const_values/urls.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/services/products_and_category_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/products_list_screen/cart_thumbnails.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/products_list_screen/category_products_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/products_list_screen/product_list_header.dart';
import 'package:provider/provider.dart';

class ProductsListScreen extends StatefulWidget {
  final PrestashopCategory category;

  const ProductsListScreen({Key key, this.category}) : super(key: key);

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProductAndCategoryProvider>(context, listen: false)
          .clearCategoryProductsData();

      ProductsAndCategoryService.fetchCategoryProductList(
          Provider.of(context, listen: false),
          URLs.categoryProducts(widget.category.categoryID()),
          Provider.of(context, listen: false),
          widget.category.categoryID());
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            color: Colors.transparent,
            height: height,
            width: width,
            child: Column(
              children: [
                ProductListHeader(
                  category: widget.category,
                ),
                Expanded(
                    child:
                        Container(color: white, child: CategoryProductsList())),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CartThumbnails(),
          )
        ],
      ),
    ));
  }
}
