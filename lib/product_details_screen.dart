import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsViewModel viewModel;

  // scroll controller
  final ScrollController _sliverScrollController = ScrollController();
  ScrollController get sliverScrollController => _sliverScrollController;
  void addListenerToScrollController() {
    _sliverScrollController.addListener(() {
      handleCollapse();
    });
  }

  bool _toolbarCollpased = false;
  bool get toolbarCollpased => _toolbarCollpased;
  void setToolbarCollapsed(bool newValue) {
    setState(() {
      _toolbarCollpased = newValue;
    });
  }

  void handleCollapse() {
    if (!_toolbarCollpased &&
        _sliverScrollController.hasClients &&
        _sliverScrollController.offset > (300 - kToolbarHeight)) {
      setToolbarCollapsed(true);
    } else if (toolbarCollpased &&
        _sliverScrollController.hasClients &&
        _sliverScrollController.offset < (300 - kToolbarHeight)) {
      setToolbarCollapsed(false);
    }
  }

  @override
  void initState() {
    super.initState();

    addListenerToScrollController();

    viewModel = ProductDetailsViewModel(product: widget.product);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      viewModel
          .getProductDetails(Provider.of<WebService>(context, listen: false));
    });
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
              toolbarCollpased: toolbarCollpased,
              images: viewModel.product.images,
              productName: viewModel.product.name,
            ),
            SliverToBoxAdapter(
              child: ProductInformation(),
            ),
            TextSliver(
              text: ConstValues().youMightAlsoLike(),
            ),
            DividerSliver(),
            SliverToBoxAdapter(child: FeaturedProductsList()),
          ],
        ),
      ),
    );
  }
}
