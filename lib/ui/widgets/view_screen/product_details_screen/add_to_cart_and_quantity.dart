import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/modal_cupertino_picker.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddToCardAndQuantity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductDetailsViewModel productDetailsVM =
        Provider.of(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(width * 0.0213),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AddToCardButton()),
          if (!productDetailsVM.getMaxQuantity().isNegative)
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: ModalCupertinoQuantityPicker(
                heightSize: width * 0.12,
                widthSize: width * 0.18,
                onChange: productDetailsVM.setSelectedQuantity,
                maxNumber: productDetailsVM.getMaxQuantity(),
                selected: productDetailsVM.selectedQuantity,
              ),
            )
        ],
      ),
    );
  }
}
