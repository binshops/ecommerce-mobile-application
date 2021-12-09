import 'package:prestashop_mobile_app/ui/shared/string_extentions.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final String price;
  final String discountPrice;

  const ProductPrice({
    Key key,
    this.price,
    this.discountPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productPrice = StringExtensions.toDouble(price ?? '0');
    var discountPrice = StringExtensions.toDouble(this.discountPrice ?? '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (discountPrice != null &&
            discountPrice > 0 &&
            productPrice > discountPrice) ...[
          TextView(
            text: '$productPrice',
            textStyle: robotoNormalPrimaryDarkLineThroughStyle(20),
          ),
          TextView(
            text: '   $discountPrice',
            textStyle: robotoNormalPrimaryDarkStyle(20),
          ),
        ] else ...[
          TextView(
            text: '$productPrice',
            textStyle: robotoNormalPrimaryDarkStyle(20),
          ),
        ]
      ],
    );
  }
}
