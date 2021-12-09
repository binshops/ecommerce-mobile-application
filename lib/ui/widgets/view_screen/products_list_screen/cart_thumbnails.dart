import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class CartThumbnails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Dialogs.dialog(context);
      },
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: width * 0.12,
              child: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.01,
                  left: width * 0.03,
                  top: width * 0.02,
                  bottom: width * 0.01,
                ),
                child: Icon(
                  Icons.shopping_basket_outlined,
                  size: width * 0.0773,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.04),
                ),
                color: primaryBinShops.withOpacity(0.5),
              ),
            ),
            Container(
                color: primaryBinShops.withOpacity(0.5),
                height: width * 0.12,
                width: width * 0.12,
                child: Container(
                    child: Center(
                        child: TextView(
                  text: '0',
                  textStyle: raleWayBoldPrimaryDarkStyle(16),
                )))),
          ],
        ),
      ),
    );
  }
}
