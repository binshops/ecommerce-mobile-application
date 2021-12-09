import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/category_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchCategoriesList extends StatelessWidget {
  const SearchCategoriesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ProductAndCategoryProvider>(
      builder: (context, productAndCategoryProvider, child) {
        return productAndCategoryProvider.bootStrapState == ViewState.busy
            ? Center(
            child: Container(
                width: width * 0.1,
                height: width * 0.1,
                child: BinshopsCircularIndicator()))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: productAndCategoryProvider.categories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                      category: productAndCategoryProvider.categories[index]);
                },
              );
      },
    );
  }
}
