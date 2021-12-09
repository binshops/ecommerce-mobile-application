import 'package:prestashop_mobile_app/const_values/urls.dart';
import 'package:prestashop_mobile_app/const_values/route_paths.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/providers/search_provider.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/services/search_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatefulWidget {
  final bool fromModalScreen;

  const SearchBarWidget({Key key, this.fromModalScreen = false})
      : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    var width = MediaQuery.of(context).size.width;
    return Padding(
      child: Container(
        height: widget.fromModalScreen ? width * 0.1 : width * 0.128,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(width * 0.0853)),
            color: lightGray),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) {
              return searchProvider.searchingState == ViewState.busy
                  ? Container(
                      margin: EdgeInsets.all(width * 0.0213),
                      width: width * 0.064,
                      height: width * 0.064,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          animating: true,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      color: primaryDark,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        if (_controller.text.trim().isNotEmpty) {
                          Provider.of<SearchProvider>(context, listen: false)
                              .clearSearchProductsData();
                          var success =
                              await SearchService.fetchSearchProductList(
                                  Provider.of(context, listen: false),
                                  URLs.searchUrl(_controller.text),
                                  searchProvider);
                          if (success) {
                            Provider.of<NavigationService>(context,
                                    listen: false)
                                .navigateTo(RoutePaths.SearchResultsScreenPath,
                                    arguments: _controller.text);
                          }
                        }
                      },
                    );
            },
          ),
          Expanded(child: textField(node, width))
        ]),
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
    );
  }

  Widget textField(node, width) {
    return Container(
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.left,
        maxLines: 1,
        keyboardType: TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        onEditingComplete: () => node.nextFocus(),
        style: raleWayNormalPrimaryDarkStyle(14),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(right: 0, bottom: width * 0.04, top: 0),
          hintText: SearchForItems,
          hintStyle: raleWayNormalPrimaryDarkStyle(14),
          border: InputBorder.none,
        ),
        cursorColor: primaryDark,
      ),
    );
  }
}
