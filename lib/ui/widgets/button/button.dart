import 'package:flutter/material.dart';
import 'package:prestashop_mobile_app/enums/view_state.dart';
import 'package:prestashop_mobile_app/ui/dialogs/dialog.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:prestashop_mobile_app/view_models/product_details_screen/product_details_viewModel.dart';
import 'package:provider/provider.dart';

class RectAngleButton extends StatelessWidget {
  final String nameOfButton;
  final TextStyle textStyle;
  final Color color;
  final double height;
  final double width;
  final VoidCallback onTap;
  final ViewState state;
  final bool fromAfterPayment;

  const RectAngleButton(
      {Key key,
      this.nameOfButton,
      this.textStyle,
      this.color,
      this.height,
      this.width,
      this.onTap,
      this.state,
      this.fromAfterPayment = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: state != ViewState.busy ? onTap : null,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          height: height,
          width: this.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: nameOfButton,
                textStyle: textStyle,
              ),
              if (state == ViewState.busy)
                Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: Container(
                    height: width * 0.05,
                    width: width * 0.05,
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  ),
                )
            ],
          ),
          decoration: fromAfterPayment
              ? BoxDecoration(
                  border: Border.all(color: white, width: 4),
                  color: color,
                )
              : BoxDecoration(
                  color: color,
                )),
    );
  }
}

class AddToCardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productDetailsVM =
        Provider.of<ProductDetailsViewModel>(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    return RectAngleButton(
      height: width * 0.144,
      width: width,
      textStyle: raleWayBoldWhiteStyle(14),
      state: productDetailsVM.fetchingProductDetailsState,
      onTap: () {
        Dialogs.dialog(context);
      },
      nameOfButton: AddToCartButtonText,
      color: primaryBinShops,
    );
  }
}

/// CLose Button
class ClosingButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final double size;

  ClosingButton({
    Key key,
    this.color,
    this.onPressed,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.close),
        color: color,
        onPressed: onPressed,
        iconSize: size ?? 24,
      ),
    );
  }
}

/// back Button
class BackingButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPress;
  final EdgeInsetsGeometry padding;

  const BackingButton({Key key, this.color, this.onPress, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: color,
        iconSize: 20,
        onPressed: onPress,
      ),
    );
  }
}
