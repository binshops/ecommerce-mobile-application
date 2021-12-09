
import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/providers/search_provider.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/app_bar_widget.dart';
import 'package:prestashop_mobile_app/ui/widgets/lazy_load_products_slivers.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatelessWidget {
  final result;

  const SearchResultsScreen({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child:
            Consumer<SearchProvider>(builder: (context, searchProvider, child) {
          return Column(
            children: [
              AppBarWidget(
                title: SearchResultFor + result,
                withBackButton: true,
                type: TypeOfAppBar.start,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                padding: EdgeInsets.all(width * 0.0213),
                child: Container(
                  width: width,
                  height: height - (width * 0.3),
                  child: searchProvider.searchResults.length != 0
                      ? LazyLoadProductsSliversWidget(
                          loadedProducts: searchProvider.searchResults,
                          totalNumber: searchProvider.totalNumber,
                          nextPageURL: searchProvider.nextPageURL,
                          isSearch: true,
                          viewState: searchProvider.searchingState,
                          addEmptySpace: false)
                      : Center(
                          child: TextView(
                            text: NoResultsFoundFor + result,
                            textStyle: raleWayBoldPrimaryDarkStyle(20),
                          ),
                        ),
                ),
              )))
            ],
          );
        }),
      ),
    );
  }
}
