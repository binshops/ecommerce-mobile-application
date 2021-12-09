import 'package:prestashop_mobile_app/models/product_related_models.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/expansion_tile_widget.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_information_row.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAdditionalInformationTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.all(width * 0.0213),
        child: ExpansionTileWidget(
          title: AdditionalInformation,
          innerWidget: Padding(
            padding: EdgeInsets.all(width * 0.0213),
            child: Column(
              children: productInformationListBuilder(
                  Provider.of<ProductDetailsViewModel>(context, listen: false)
                      .product
                      .productInfo),
            ),
          ),
        ));
  }

  List<Widget> productInformationListBuilder(ProductInfo productInfo) {
    List<Widget> infoList = [];
    if (productInfo != null)
      for (var i = 0; i < productInfo.info.length; i++)
        infoList.add(ProductInformationRow(
          name: productInfo.info[i].name,
          value: productInfo.info[i].value,
        ));
    return infoList;
  }
}
