import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/widgets/back_and_label_row.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/products_list_screen/products_lis_screen_row.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListHeader extends StatelessWidget {
  final PrestashopCategory category;

  const ProductListHeader({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          color: primaryBinShops,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width,
                child: Padding(
                  padding: EdgeInsets.only(top: width * 0.04),
                  child: SearchBarWidget(
                    fromModalScreen: true,
                  ),
                ),
              ),
              BackAndLabelRow(
                padding: EdgeInsets.only(
                    top: width * 0.01,
                    bottom: width * 0.01,
                    left: width * 0.02,
                    right: width * 0.01),
                backButton: () => backButton(context),
                closeButton: IconButton(
                  icon: Icon(Icons.list),
                  color: white,
                  onPressed: () {
                    Dialogs.dialog(context);
                  },
                  iconSize: width * 0.0666,
                ),
                label: category.label ?? ' ',
              ),
              ProductsListScreenRow(
                padding: EdgeInsets.only(
                    left: width * 0.045,
                    right: width * 0.04,
                    bottom: width * 0.01),
              )
            ],
          ),
        ),
      ],
    );
  }

  void backButton(BuildContext context) {
    Provider.of<NavigationService>(context, listen: false).goBack();
  }
}
