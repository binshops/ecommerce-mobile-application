import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/presta_banner.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/widgets/binshops_logo.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/featured_products_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/home_screen/home_categories_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/home_screen/home_sliders.dart';
import 'package:prestashop_mobile_app/ui/extensions/widget_extension.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _bannersBuilder(PrestaBanner prestaBanner, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: width * 0.04),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.04),
        child: ImageAndIconFill(
          name: prestaBanner.imageUrl,
          fromNetWork: true,
          width: width,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ProductAndCategoryProvider>(
        builder: (context, productAndCatProvider, child) {
      if (productAndCatProvider.bootStrapState == ViewState.busy) {
        return Container().withBusyOverlay(
            productAndCatProvider.bootStrapState == ViewState.busy,
            withOpacity: false);
      } else {
        return SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                HomeScreenToolBar(),
                SizedBox(height: width * 0.0426),
                HomeSliders(
                  productAndCategoryProvider: productAndCatProvider,
                ),
                SizedBox(height: width * 0.0426),
                HomeCategoriesList(),
                FeaturedProductsList(),
                _bannersBuilder(productAndCatProvider.prestaBanner, context),
              ]),
        );
      }
    });
  }
}

class HomeScreenToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: width, alignment: Alignment.center, child: BinShopsLogo());
  }
}
