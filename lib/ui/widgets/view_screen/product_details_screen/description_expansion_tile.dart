import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/expansion_tile_widget.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class DescriptionExpansionTile extends StatelessWidget {
  const DescriptionExpansionTile({
    Key key,
    this.productDescription,
  }) : super(key: key);

  final String productDescription;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.all(width * 0.0213),
        child: ExpansionTileWidget(
          title: Description,
          innerWidget: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.0213, vertical: width * 0.0213),
            child: TextView(
              text: productDescription,
              textStyle: raleWayBoldBlackStyle(14),
            ),
          ),
        ));
  }
}
