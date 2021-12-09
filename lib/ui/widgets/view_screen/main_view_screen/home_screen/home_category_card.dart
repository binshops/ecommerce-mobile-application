import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/prestashop_category.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCategoryCard extends StatelessWidget {
  final PrestashopCategory category;

  const HomeCategoryCard({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.042),
        child: Column(
          children: [
            ImageAndIconFill(
              onTap: () {
                Provider.of<NavigationService>(context, listen: false)
                    .navigateTo(RoutePaths.ProductsListScreen,
                        arguments: category);
              },
              name: category.imageUrls.first,
              width: width * 0.23,
              height: width * 0.23,
              fromNetWork: true,
            ),
            SizedBox(height: width * 0.04),
            TextView(
              text: category.label,
              textStyle: robotoNormalBlackStyle(11),
            )
          ],
        ));
  }
}
