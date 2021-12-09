import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/add_to_cart_and_quantity.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/description_expansion_tile.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_more_info_table.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_name.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_options.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_price.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/review_expansion_tile.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ProductDetailsViewModel>(
      builder: (context, productDetailsVM, child) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.0213, width * 0.04, width * 0.021, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProductName(productName: productDetailsVM.product.name),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.021),
                child: ProductPrice(
                  discountPrice: productDetailsVM.product.discountPrice,
                  price: productDetailsVM.product.price,
                ),
              ),
              ProductOptions(),
              AddToCardAndQuantity(),
              DescriptionExpansionTile(
                productDescription: productDetailsVM.product.description,
              ),
              ReviewExpansionTile(),
              ProductAdditionalInformationTable(),
            ],
          ),
        );
      },
    );
  }
}
