import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final String productName;

  const ProductName({
    Key key,
    @required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.all(width * 0.0213),
        child: TextView(
          text: productName ?? '',
          textStyle: raleWayNormalPrimaryDarkStyle(18),
        ));
  }
}
