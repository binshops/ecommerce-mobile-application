import 'package:prestashop_mobile_app/models/product_related_models.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/option_button.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOptions extends StatelessWidget {
  List<Widget> optionsBuilder(
      {@required List<Option> options,
      @required Function(int, Item) onSelectItem,
      @required Map<int, List<Item>> availableItems,
      @required Map<int, Item> selectedItems}) {
    var optionWidgets = <Widget>[];

    for (var option in options) {
      if (availableItems[option.id] != null &&
          availableItems[option.id].isNotEmpty)
        optionWidgets.add(OptionButton(
          items: availableItems[option.id],
          option: option,
          selectedItem: selectedItems[option.id],
          onSelectItem: onSelectItem,
        ));
    }

    return optionWidgets;
  }

  @override
  Widget build(BuildContext context) {
    var productDetailsVM =
        Provider.of<ProductDetailsViewModel>(context, listen: false);

    return Column(children: [
      if (productDetailsVM.product.combinations.isNotEmpty)
        ...optionsBuilder(
            onSelectItem: productDetailsVM.onSelectItem,
            availableItems: productDetailsVM.availableItemsForEachOption,
            options: productDetailsVM.product.options,
            selectedItems: productDetailsVM.selectedValuesOfOptions),
    ]);
  }
}
