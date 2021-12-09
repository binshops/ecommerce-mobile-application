import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class ProductInformationRow extends StatelessWidget {
  final String name;
  final String value;

  const ProductInformationRow({
    Key key,
    this.name = '',
    this.value = '',
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
          text: name,
          textStyle: raleWayBoldPrimaryDarkStyle(14),
        ),
        TextView(
          text: value,
          textStyle: raleWayBoldBlackStyle(14),
        ),
      ],
    );
  }
}
