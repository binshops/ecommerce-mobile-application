import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/second_sub_category_item.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/sub_category_item_row.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/binshops_expansion_tile_category.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstSubCategoryItem extends StatefulWidget {
  final PrestashopCategory category;

  FirstSubCategoryItem({Key key, this.category}) : super(key: key);

  @override
  _FirstSubCategoryItemState createState() => _FirstSubCategoryItemState();
}

class _FirstSubCategoryItemState extends State<FirstSubCategoryItem> {
  var isExpanded = false;

  _onExpansionChanged(bool val) {
    if (widget.category.children.isNotEmpty) {
      setState(() {
        isExpanded = val;
      });
    } else {
      Provider.of<NavigationService>(context, listen: false).navigateTo(
          RoutePaths.ProductsListScreen,
          arguments: widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BinshopsExpansionTileCategory(
      title: TextView(
          text: widget.category.label,
          textStyle: raleWayNormalPrimaryDarkStyle(16)),
      trailing: SubCategoryItemRow(
          isExpanded: isExpanded, items: widget.category.children.length),
      padding: EdgeInsets.only(left: width * 0.1107, right: width * 0.05),
      paddingDivider:
          EdgeInsets.only(left: width * 0.105, right: width * 0.088),
      heightDivider: 1,
      onExpansionChanged: _onExpansionChanged,
      children: [
        ListView.builder(
          reverse: true,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemCount: widget.category.children.length,
          itemBuilder: (context, index) {
            return SecondSubCategoryItem(
              category: widget.category.children[index],
            );
          },
        ),
      ],
    );
  }
}
