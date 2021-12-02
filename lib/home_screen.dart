import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Function openDrawer;

  const HomeScreen({Key? key, required this.openDrawer}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _bannersBuilder(List<Slide> slides) {
    var banners = <Widget>[];
    for (var slide in slides) {
      banners.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.s),
        child: BannerWidget(
          slide: slide,
        ),
      ));
    }
    return banners;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAndCategoryProvider>(
        builder: (context, productAndCatProvider, child) {
      return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    iconSize: Sizes.m,
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      widget.openDrawer();
                    }),
                AppLogo(),
                Container(
                  width: Sizes.m,
                )
              ]),
              Spaces.verticalSpaceSmall,
              HomeCategoriesList(),
              FeaturedProductsList(),
              ..._bannersBuilder(Provider.of<ProductAndCategoryProvider>(
                      context,
                      listen: false)
                  .slides),
            ]),
      ).withBusyOverlay(productAndCatProvider.bootStrapState == ViewState.busy,
          withOpacity: false);
    });
  }
}
