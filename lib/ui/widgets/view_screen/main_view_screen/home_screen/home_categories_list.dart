import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/home_screen/home_category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<ProductAndCategoryProvider>(
      builder: (context, productAndCatProvider, child) {
        return Container(
          height: width * 0.34,
          width: width,
          child: productAndCatProvider.bootStrapState == ViewState.busy
              ? Center(
                  child: Container(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productAndCatProvider.categories.length,
                    itemBuilder: (context, index) {
                      return HomeCategoryCard(
                        category: productAndCatProvider.categories[index],
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
