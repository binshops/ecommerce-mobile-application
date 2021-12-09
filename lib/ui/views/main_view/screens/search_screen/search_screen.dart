import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/categories_list/search_categories_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/search_screen/search_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: width * 0.04),
              child: SearchBarWidget(),
            ),
            Expanded(
              child: SearchCategoriesList(),
            ),
          ],
        ),
      ),
    );
  }
}
