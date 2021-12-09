import 'package:prestashop_mobile_app/models/product_related_models.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/product_details_screen/options_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key key,
    this.option,
    this.onSelectItem,
    this.items,
    this.selectedItem,
  }) : super(key: key);
  final Option option;
  final List<Item> items;
  final Function(int, Item) onSelectItem;
  final Item selectedItem;

  void onCupertinoItemChanged(int index) {
    onSelectItem(option.id, items[index]);
  }

  List<Widget> cupertinoChildrenBuilder() {
    var children = <Widget>[];
    items.forEach((item) {
      children.add(OptionItemWidget(
        value: item.value,
      ));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: width * 0.53,
              child: CupertinoPicker(
                  itemExtent: width * 0.128,
                  onSelectedItemChanged: onCupertinoItemChanged,
                  children: cupertinoChildrenBuilder()),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(width * 0.0213),
        height: width * 0.133,
        padding: EdgeInsets.only(left: width * 0.0213),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFFF1F2F3)),
        ),
        child: Row(children: [
          TextView(
            text: option.title,
            textStyle: raleWayBoldPrimaryDarkStyle(14),
          ),
          Expanded(child: SizedBox()),
          TextView(
            text: selectedItem?.value ?? '',
            textStyle: robotoNormalPrimaryDarkStyle(14),
          ),
          SizedBox(width: width * 0.0213),
          Icon(Icons.keyboard_arrow_down)
        ]),
      ),
    );
  }
}
