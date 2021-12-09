import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/expantion_tile/binshops_expansion_tile.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final Widget innerWidget;
  final Key formKey;

  const ExpansionTileWidget(
      {Key key, this.title, this.innerWidget, this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BinshopsExpansionTile(
      key: formKey,
      title: TextView(
        text: title,
        textStyle: raleWayBoldBlackStyle(16),
      ),
      children: [innerWidget],
    );
  }
}
