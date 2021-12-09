import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/lazy_load_products_slivers.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ProductAndCategoryProvider>(
      builder: (context, prodProvider, child) {
        if (prodProvider.getCategoryProductsState == ViewState.busy) {
          return Center(
              child: Container(
                  width: width * 0.1,
                  height: width * 0.1,
                  child: BinshopsCircularIndicator()));
        } else {
          if (prodProvider.categoryProducts.length == 0)
            return Container(
              color: white,
              width: width,
              child: Center(
                child: TextView(
                  text: NoProductFound,
                  textStyle: robotoNormalPrimaryDarkStyle(18),
                ),
              ),
            );
          else
            return LazyLoadProductsSliversWidget(
                loadedProducts: prodProvider.categoryProducts,
                totalNumber: prodProvider.totalNumber,
                nextPageURL: prodProvider.nextPageURL,
                isSearch: false,
                viewState: prodProvider.bootStrapState,
                addEmptySpace: false);
        }
      },
    );
  }
}
