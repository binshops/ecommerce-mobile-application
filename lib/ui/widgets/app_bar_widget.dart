import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TypeOfAppBar { start, end }

class AppBarWidget extends StatelessWidget {
  final String title;
  final TypeOfAppBar type;
  final bool withBackButton;

  const AppBarWidget(
      {Key key, this.title, this.type, this.withBackButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: alignment(type),
      children: [
        Container(
          width: width,
          height: width * 0.1333,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1333),
              child: Container(
                width: width,
                child: TextView(
                  text: title,
                  textStyle: raleWayBoldPrimaryDarkStyle(16),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          color: lightGray,
        ),
        if (withBackButton) iconButton(type, width, context)
      ],
    );
  }

  AlignmentDirectional alignment(TypeOfAppBar type) {
    switch (type) {
      case TypeOfAppBar.start:
        return AlignmentDirectional.centerStart;
      case TypeOfAppBar.end:
        return AlignmentDirectional.centerEnd;
    }
    return AlignmentDirectional.centerStart;
  }

  Widget iconButton(TypeOfAppBar type, double width, BuildContext context) {
    switch (type) {
      case TypeOfAppBar.start:
        return Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: BackingButton(
            color: primaryDark,
            onPress: () =>
                Provider.of<NavigationService>(context, listen: false).goBack(),
          ),
        );
      case TypeOfAppBar.end:
        return ClosingButton(
          color: secondaryGray,
          onPressed: () {
            Provider.of<NavigationService>(context, listen: false).goBack();
          },
        );
    }
    return Container();
  }
}
