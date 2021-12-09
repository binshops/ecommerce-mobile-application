import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeaturedProductsList extends StatelessWidget {
  const FeaturedProductsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * 0.76,
      child: Consumer<ProductAndCategoryProvider>(
        builder: (context, productAndCategoryProvider, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productAndCategoryProvider.topProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: productAndCategoryProvider.topProducts[index],
              );
            },
          );
        },
      ),
    );
  }
}
