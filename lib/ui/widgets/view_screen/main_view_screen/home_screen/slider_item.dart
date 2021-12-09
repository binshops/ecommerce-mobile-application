import 'package:prestashop_mobile_app/models/slide.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:flutter/material.dart';
class SliderItem extends StatelessWidget {
  final Slide slide;
  SliderItem({this.slide});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ImageBorder(
      name: slide.imageUrl,
      fromNetWork: true,
      border: width * 0.04,
    );
  }
}
