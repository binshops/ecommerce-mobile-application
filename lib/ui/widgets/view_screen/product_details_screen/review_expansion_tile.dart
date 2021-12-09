import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/expansion_tile_widget.dart';
import 'package:flutter/material.dart';

class ReviewExpansionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.all(width * 0.0213),
        child: ExpansionTileWidget(
          title: ReadReviews,
          innerWidget: Padding(
            padding: EdgeInsets.all(width * 0.0213),
          ),
        ));
  }
}
