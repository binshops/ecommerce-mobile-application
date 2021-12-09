import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class TextSliver extends StatelessWidget {
  const TextSliver({
    Key key,
    this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
            left: width * 0.0426, bottom: width * 0.0213, top: width * 0.0213),
        child: TextView(
          text: text,
          textStyle: raleWayBoldPrimaryDarkStyle(18),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
