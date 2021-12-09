import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/app_bar_widget.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/user_management/account_info/user_info.dart';

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarWidget(
            title: MyAccount,
            type: TypeOfAppBar.end,
            withBackButton: false,
          ),
          UserInfoWidget(),
        ],
      ),
    );
  }
}
