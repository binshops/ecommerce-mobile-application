import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:flutter/material.dart';

class BinShopsLogo extends StatelessWidget {
  const BinShopsLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.0426),
      child:
      ImageAndIconFill(
        name: Logo,
        height: width * 0.09,
        width: width * 0.35,
      )
    );
  }
}
