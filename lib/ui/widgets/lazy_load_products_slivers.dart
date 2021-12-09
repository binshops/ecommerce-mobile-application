import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/services/products_and_category_service.dart';
import 'package:prestashop_mobile_app/services/search_service.dart';
import 'package:prestashop_mobile_app/ui/widgets/product_card.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LazyLoadProductsSliversWidget extends StatefulWidget {
  final List<Product> loadedProducts;
  final String totalNumber;
  final String nextPageURL;
  final ViewState viewState;
  final bool isSearch;
  final addEmptySpace;

  LazyLoadProductsSliversWidget(
      {Key key,
      this.loadedProducts,
      this.addEmptySpace,
      this.totalNumber,
      this.nextPageURL,
      this.viewState,
      this.isSearch})
      : super(key: key);

  @override
  _LazyLoadProductsSliversWidgetState createState() =>
      _LazyLoadProductsSliversWidgetState();
}

class _LazyLoadProductsSliversWidgetState
    extends State<LazyLoadProductsSliversWidget> {
  bool scrollDown = false;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (widget.viewState != ViewState.busy &&
          int.parse(widget.totalNumber) > widget.loadedProducts.length) {
        setState(() {
          scrollDown = true;
        });
        var success = widget.isSearch
            ? await SearchService.fetchSearchProductList(
                Provider.of(context, listen: false),
                widget.nextPageURL,
                Provider.of(context, listen: false))
            : await ProductsAndCategoryService.fetchCategoryProductList(
                Provider.of(context, listen: false),
                widget.nextPageURL,
                Provider.of(context, listen: false),
                null);

        if (success) {
          setState(() {
            scrollDown = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return NotificationListener(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification)
            FocusScope.of(context).requestFocus(new FocusNode());
          return false;
        },
        child: CustomScrollView(
          controller: _controller,
          cacheExtent: 1000,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return index < widget.loadedProducts.length
                      ? Container(
                          child: ProductCard(
                            product: widget.loadedProducts[index],
                            fromCategoryProductList:
                                !widget.isSearch ? true : false,
                          ),
                        )
                      : SizedBox();
                },
                childCount: !widget.addEmptySpace
                    ? widget.loadedProducts.length
                    : widget.loadedProducts.length.isEven
                        ? widget.loadedProducts.length + 1
                        : widget.loadedProducts.length + 2,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                  maxCrossAxisExtent: 280),
            ),
            if (scrollDown)
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                Padding(
                    padding: EdgeInsets.only(bottom: width * 0.0853),
                    child: Center(
                      child: Container(
                          width: width * 0.1,
                          height: width * 0.1,
                          child: BinshopsCircularIndicator()),
                    ))
              ]))
          ],
        ));
  }
}
