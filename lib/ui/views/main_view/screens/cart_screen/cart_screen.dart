import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/app_bar_widget.dart';
import 'package:prestashop_mobile_app/ui/widgets/featured_products_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/cart_screen/no_cart_items.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                title: MyCartText,
                type: TypeOfAppBar.end,
                withBackButton: false,
              ),
              NoCartItemsWidget(),
              SizedBox(height: width * 0.085),
              youMightAlsoLikeWidget(context),
              FeaturedProductsList()
            ],
          ),
        ),
      ),
    );
  }

  Widget youMightAlsoLikeWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: width * 0.0426,
              bottom: width * 0.0213,
              top: width * 0.0213),
          child: TextView(
            text: YouMightAlsoLike,
            textStyle: raleWayBoldPrimaryDarkStyle(18),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: width * 0.02),
          child: Divider(
            height: 1,
            thickness: 1,
            color: lightGray,
            indent: MediaQuery.of(context).size.width * 0.0465,
            endIndent: MediaQuery.of(context).size.width * 0.1323,
          ),
        ),
      ],
    );
  }
}
