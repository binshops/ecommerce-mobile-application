import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class SubCategoryItemRow extends StatelessWidget {
  final bool isExpanded;
  final int items;

  const SubCategoryItemRow({Key key, this.isExpanded, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isExpanded
            ? Icon(
                Icons.keyboard_arrow_up,
                color: black,
                size: width * 0.05,
              )
            : Icon(
                Icons.keyboard_arrow_right,
                color: black,
                size: width * 0.05,
              ),
      ],
    );
  }
}
