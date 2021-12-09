import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/providers/bottom_navigation.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/services/home_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/cart_screen/cart_screen.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/home_screen/home_screen.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/search_screen/search_screen.dart';
import 'package:prestashop_mobile_app/ui/views/main_view/screens/user_management_screen/user_management_screen.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BinshopsMainPage();
  }
}

class BinshopsMainPage extends StatefulWidget {
  @override
  _BinshopsMainPageState createState() => _BinshopsMainPageState();
}

class _BinshopsMainPageState extends State<BinshopsMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _tabs = [HomeScreen(), SearchScreen(), CartScreen(), UserManagement()];

  @override
  void initState() {
    var productAndCategoryProvider =
        Provider.of<ProductAndCategoryProvider>(context, listen: false);
    productAndCategoryProvider.setFirstBootstrapState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await HomeService.fetchBootStrapData(Provider.of(context, listen: false),
          Provider.of(context, listen: false), productAndCategoryProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: white,
        body: SafeArea(
          child: Consumer<BottomNavigation>(
              builder: (context, bottomNavigation, child) {
            return GestureDetector(
              child: _tabs[bottomNavigation.counter],
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onVerticalDragStart: (details) =>
                  FocusScope.of(context).requestFocus(new FocusNode()),
            );
          }),
        ),
        bottomNavigationBar: Consumer<BottomNavigation>(
            builder: (context, bottomNavigation, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: white,
            currentIndex: bottomNavigation.counter,
            onTap: bottomNavigation.setCounter,
            selectedItemColor: black,
            unselectedItemColor: mainViewUnSelectedItemColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedIconTheme: IconThemeData(size: width * 0.06),
            unselectedIconTheme: IconThemeData(size: width * 0.05),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: MainViewBottomNavigationHome),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: MainViewBottomNavigationSearch),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: MainViewBottomNavigationShop),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: MainViewBottomNavigationProfile),
            ],
          );
        }));
  }
}
