import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class SortBy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: SortByText,
            textStyle: robotoNormalPrimaryDarkStyle(14),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: width * 0.02666,
          ),
          Icon(
            Icons.compress,
            color: primaryDark,
            size: width * 0.064,
          ),
        ],
      ),
      onTap: () {
        Dialogs.dialog(context);
      },
    );
  }
}
