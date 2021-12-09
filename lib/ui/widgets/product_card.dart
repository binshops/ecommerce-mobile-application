import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';
import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final onTap;
  final longOnTap;
  final EdgeInsetsGeometry padding;
  final bool fromCategoryProductList;

  ProductCard(
      {Key key,
      this.product,
      this.onTap,
      this.longOnTap,
      this.padding,
      this.fromCategoryProductList = false})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  WebService webService;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var widthOfCard = width * 0.48;
    webService = Provider.of<WebService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Provider.of<NavigationService>(context, listen: false).navigateTo(
            RoutePaths.ProductDetailPath,
            arguments: widget.product);
      },
      onLongPress: () {
        if (widget.fromCategoryProductList) {
          Dialogs.dialog(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.0213),
        child: Container(
          width: widthOfCard,
          height: height,
          child: Column(
            children: [
              Expanded(
                  flex: 72,
                  child: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: width * 0.0122, bottom: width * 0.0122),
                            child: ImageAndIconFill(
                              name: widget.product.images[0] ?? ' ',
                              height: height,
                              width: width,
                              fromNetWork: true,
                            )),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 28,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: width * 0.0122),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        style:
                                            raleWayNormalPrimaryDarkStyle(14),
                                        text: widget.product.name ?? ' '),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: width * 0.0122),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          style: normalPrimaryDarkStyle(18),
                                          text: widget.product.price),
                                    ),
                                  ),
                                ])),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
