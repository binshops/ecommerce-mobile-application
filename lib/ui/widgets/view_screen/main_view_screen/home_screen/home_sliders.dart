import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/widgets/view_screen/main_view_screen/home_screen/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSliders extends StatelessWidget {
  final ProductAndCategoryProvider productAndCategoryProvider;

  const HomeSliders({Key key, this.productAndCategoryProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: width * 0.35,
      child: Swiper(
        viewportFraction: 0.91,
        scale: 0.95,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: width * 0.07),
            child: SliderItem(
              slide: productAndCategoryProvider.slides[index],
            ),
          );
        },
        autoplay: true,
        itemCount: productAndCategoryProvider.slides.length,
        pagination: SwiperPagination(
            margin: EdgeInsets.all(0.0),
            builder: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
              return ConstrainedBox(
                child: Align(
                  alignment: Alignment.center,
                  child: DotSwiperPaginationBuilder(
                    color: Color(0xFF848484),
                    activeColor: black,
                    size: MediaQuery.of(context).size.width * 0.015,
                  ).build(context, config),
                ),
                constraints: BoxConstraints.expand(height: width * 0.048),
              );
            })),
        control: SwiperControl(size: 0),
      ),
    );
  }
}
