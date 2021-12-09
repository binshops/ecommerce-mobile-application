import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/user_management/buttons/login_button.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        top: width * 0.0426,
        left: width * 0.0853,
      ),
      child: LoginButton(),
    );
  }
}
