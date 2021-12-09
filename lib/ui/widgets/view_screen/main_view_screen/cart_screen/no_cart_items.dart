import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class NoCartItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Center(
        child: Column(
      children: <Widget>[
        SizedBox(height: width * 0.0853),
        TextView(
          text: YourBagIsEmpty,
          textStyle: raleWayBoldBlackStyle(19),
        ),
        SizedBox(height: width * 0.0853),
        TextView(
          text: noCartItemsWidget,
          textStyle: raleWayNormalPrimaryDarkStyle(15),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: width * 0.128),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.04, horizontal: width * 0.06),
          child: RectAngleButton(
            width: width,
            height: width * 0.144,
            textStyle: raleWayBoldWhiteStyle(14),
            nameOfButton: StartShoppingText,
            color: primaryDark,
            onTap: () {
              Dialogs.dialog(context);
            },
          ),
        )
      ],
    ));
  }
}
