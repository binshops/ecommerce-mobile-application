import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:flutter/material.dart';

class DividerSliver extends StatelessWidget {
  const DividerSliver({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(bottom: width * 0.066),
        child: Divider(
          height: 1,
          thickness: 1,
          color: lightGray,
          indent: MediaQuery.of(context).size.width * 0.0465,
          endIndent: MediaQuery.of(context).size.width * 0.1323,
        ),
      ),
    );
  }
}
