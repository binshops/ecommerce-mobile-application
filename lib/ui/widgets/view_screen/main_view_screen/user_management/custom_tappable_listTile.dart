import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class CustomTappableListTile extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final Widget rightWidget;
  final VoidCallback onTap;

  const CustomTappableListTile(
      {Key key, this.title, this.leftIcon, this.rightWidget, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: width * 0.16,
        width: width * 0.8933,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: width * 0.02),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        leftIcon,
                        size: width * 0.08,
                        color: userManagementIconColor,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      TextView(
                        text: title,
                        textStyle: normalPrimaryDarkStyle(16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.05),
                  child: rightWidget,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: Divider(
                height: 1,
                thickness: 1,
                color: lightGray,
                indent: width * 0.12,
                endIndent: width * 0.01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
