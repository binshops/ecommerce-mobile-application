import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class BackAndLabelRow extends StatelessWidget {
  final VoidCallback backButton;
  final Widget closeButton;
  final EdgeInsetsGeometry padding;
  final String label;

  const BackAndLabelRow(
      {Key key, this.backButton, this.closeButton, this.padding, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                backButton != null
                    ? BackingButton(
                        color: white,
                        onPress: backButton,
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(
                      left: backButton == null ? width * 0.06 : 0),
                  child: TextView(
                      text: label,
                      overflow: TextOverflow.ellipsis,
                      textStyle: raleWayBoldWhiteStyle(16)),
                ),
              ],
            ),
          ),
          closeButton,
        ],
      ),
    );
  }
}
