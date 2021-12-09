import 'package:prestashop_mobile_app/const_values/assets.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalCupertinoQuantityPicker extends StatelessWidget {
  final double heightSize;
  final double widthSize;
  final int maxNumber;
  final int selected;
  final Function(int) onChange;

  ModalCupertinoQuantityPicker(
      {Key key,
      this.heightSize,
      this.widthSize,
      this.maxNumber,
      this.selected,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => showModal(context, width),
      child: Container(
        height: heightSize,
        width: widthSize,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: cupertinoPickerBorderColor)),
        child: Padding(
          padding: EdgeInsets.only(right: width * 0.0213),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.0213),
                child: TextView(
                  text: '${selected.toString()}',
                  textStyle: robotoNormalBlackStyle(14),
                ),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );
  }

  int getInitialNumber() {
    if (maxNumber < selected) {
      return maxNumber;
    }
    return selected;
  }

  showModal(BuildContext context, width) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: width * 0.53,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: (getInitialNumber()) - 1),
              backgroundColor: white,
              onSelectedItemChanged: (newValue) {
                onChange(newValue + 1);
              },
              itemExtent: 32.0,
              children: [
                for (var i = 1; i <= maxNumber; i++)
                  TextView(
                      text: '$i',
                      textStyle: TextStyle(
                        color: black,
                        fontFamily: Assets.Roboto,
                      )),
              ],
            ),
          );
        });
  }
}
