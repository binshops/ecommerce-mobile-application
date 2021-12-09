import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/models/product.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/widgets/featured_products_list.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/divider_sliver.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_details_sliver_app_bar.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/product_information.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/text_sliver.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsViewModel viewModel;
  var _toolbarCollapsed = false;

  // scroll controller
  final ScrollController _sliverScrollController = ScrollController();

  ScrollController get sliverScrollController => _sliverScrollController;

  bool get toolbarCollapsed => _toolbarCollapsed;

  @override
  void initState() {
    super.initState();

    addListenerToScrollController();

    viewModel = ProductDetailsViewModel(product: widget.product);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      viewModel
          .getProductDetails(Provider.of<WebService>(context, listen: false));
    });
  }

  void addListenerToScrollController() {
    _sliverScrollController.addListener(() {
      handleCollapse();
    });
  }

  void setToolbarCollapsed(bool newValue) {
    setState(() {
      _toolbarCollapsed = newValue;
    });
  }

  void handleCollapse() {
    if (!_toolbarCollapsed &&
        _sliverScrollController.hasClients &&
        _sliverScrollController.offset > (300 - kToolbarHeight)) {
      setToolbarCollapsed(true);
    } else if (toolbarCollapsed &&
        _sliverScrollController.hasClients &&
        _sliverScrollController.offset < (300 - kToolbarHeight)) {
      setToolbarCollapsed(false);
    }
  }

  @override
  void dispose() {
    _sliverScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsViewModel>(
      create: (context) => viewModel,
      child: Scaffold(
        body: CustomScrollView(
          controller: sliverScrollController,
          slivers: <Widget>[
            ProductDetailsSliverAppBar(
              toolbarCollpased: toolbarCollapsed,
              images: viewModel.product.images,
              productName: viewModel.product.name,
            ),
            SliverToBoxAdapter(
              child: ProductInformation(),
            ),
            TextSliver(
              text: YouMightAlsoLike,
            ),
            DividerSliver(),
            SliverToBoxAdapter(child: FeaturedProductsList()),
          ],
        ),
      ),
    );
  }
}
