import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/products_list_screen/sort_by.dart';
import 'package:flutter/material.dart';

class ProductsListScreenRow extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const ProductsListScreenRow({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.02),
            topRight: Radius.circular(width * 0.02)),
        color: white,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          height: width * 0.13,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_circle_outlined,
                      color: secondaryGray,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextView(
                        text: tap$Hold,
                        textStyle: robotoNormalPrimaryGrayStyle(12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SortBy()
            ],
          ),
        ),
      ),
    );
  }
}
