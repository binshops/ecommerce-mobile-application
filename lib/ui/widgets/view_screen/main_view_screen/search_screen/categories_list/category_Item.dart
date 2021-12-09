import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/first_sub_category_item.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/binshops_expansion_tile_category.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatefulWidget {
  final PrestashopCategory category;

  CategoryItem({Key key, this.category}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
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
      title: Padding(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.02,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
              color: lightGray),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.1230),
                child: TextView(
                    text: widget.category.label,
                    textStyle: raleWayBoldPrimaryDarkStyle(14)),
              ),
              Container(
                height: width * 0.32,
                width: width * 0.32,
                child: widget.category.imageUrls.last != ''
                    ? ImageAndIconFill(
                        name: widget.category.imageUrls.last,
                        fromNetWork: true,
                        width: width,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
      onExpansionChanged: _onExpansionChanged,
      children: [
        ListView.builder(
          reverse: true,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemCount: widget.category.children.length,
          itemBuilder: (context, index) {
            return FirstSubCategoryItem(
              category: widget.category.children[index],
            );
          },
        ),
      ],
    );
  }
}
