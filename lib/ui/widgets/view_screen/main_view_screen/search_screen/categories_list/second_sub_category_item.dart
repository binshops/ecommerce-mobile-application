import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/sub_category_item_row.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/binshops_expansion_tile_category.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondSubCategoryItem extends StatefulWidget {
  final PrestashopCategory category;

  SecondSubCategoryItem({Key key, this.category}) : super(key: key);

  @override
  _SecondSubCategoryItemState createState() => _SecondSubCategoryItemState();
}

class _SecondSubCategoryItemState extends State<SecondSubCategoryItem> {
  var isExpanded = false;

  _onExpansionChanged(bool val) {
    setState(() {
      Provider.of<NavigationService>(context, listen: false).navigateTo(
          RoutePaths.ProductsListScreen,
          arguments: widget.category);
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BinshopsExpansionTileCategory(
      title: TextView(
          text: widget.category.label,
          textStyle: raleWayNormalPrimaryDarkStyle(14)),
      trailing: SubCategoryItemRow(
          isExpanded: isExpanded, items: widget.category.children.length),
      padding: EdgeInsets.only(left: width * 0.205, right: width * 0.05),
      paddingDivider: EdgeInsets.only(left: width * 0.2, right: width * 0.088),
      heightDivider: 1,
      onExpansionChanged: _onExpansionChanged,
    );
  }
}
