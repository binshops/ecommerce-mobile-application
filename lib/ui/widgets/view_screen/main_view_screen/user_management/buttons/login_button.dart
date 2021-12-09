import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/user_management/custom_tappable_listTile.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CustomTappableListTile(
      leftIcon: (Icons.verified_user_outlined),
      rightWidget: Icon(
        Icons.arrow_forward_ios_outlined,
        size: width * 0.048,
        color: userManagementIconColor,
      ),
      title: Login,
      onTap: () {
        Dialogs.dialog(context);
      },
    );
  }
}
