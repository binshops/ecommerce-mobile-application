import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Dialogs {
  static void dialog(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetAnimationDuration: const Duration(milliseconds: 10),
        child: Container(
          height: width * 0.48,
          width: width * 0.8,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(
              Radius.circular(width * 0.0286),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: width * 0.0426, bottom: width * 0.0426),
                    child: TextView(
                      text: DialogHeader,
                      textStyle: raleWayBoldPrimaryDarkStyle(18),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.8,
                    color: primaryGray,
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.0213, right: width * 0.0213),
                  child: TextView(
                    text: DialogBody,
                    textStyle: raleWayBoldPrimaryDarkStyle(15),
                    textAlign: TextAlign.center,
                  )),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(width * 0.0286),
                    bottomLeft: Radius.circular(width * 0.0286)),
                child: RectAngleButton(
                  height: width * 0.1066,
                  width: width * 0.8,
                  nameOfButton: DialogButton,
                  textStyle: raleWayBoldWhiteStyle(width * 0.0426),
                  color: primaryBinShops,
                  onTap: () {
                    Provider.of<NavigationService>(context, listen: false)
                        .goBack();
                    launch(DialogLink);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
