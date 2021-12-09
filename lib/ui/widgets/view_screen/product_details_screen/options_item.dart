import 'package:prestashop_mobile_app/const_values/assets.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';

class OptionItemWidget extends StatelessWidget {
  const OptionItemWidget({
    Key key,
    this.value,
  }) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextView(
          text: value,
          textStyle: TextStyle(
            color: black,
            fontFamily: Assets.Roboto,
          )),
    );
  }
}
