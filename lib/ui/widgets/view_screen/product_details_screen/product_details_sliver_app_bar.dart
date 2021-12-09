import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text_style.dart';
import 'package:prestashop_mobile_app/ui/widgets/blog.dart';
import 'package:prestashop_mobile_app/ui/widgets/button/button.dart';
import 'package:prestashop_mobile_app/ui/widgets/text/TextView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class ProductDetailsSliverAppBar extends StatelessWidget {
  const ProductDetailsSliverAppBar({
    Key key,
    @required this.toolbarCollpased,
    this.images,
    this.productName,
  }) : super(key: key);

  final bool toolbarCollpased;
  final List<String> images;
  final String productName;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SliverAppBar(
      title: AnimatedOpacity(
        opacity: toolbarCollpased ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: TextView(
          text: productName,
          textStyle: raleWayBoldPrimaryDarkStyle(16),
        ),
      ),
      leading: ClosingButton(
        color: black,
        onPressed: () {
          Provider.of<NavigationService>(context,listen: false).goBack();
        },
      ),
      backgroundColor: productDetailsSliverAppBarColor,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        background: ExcludeSemantics(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ImageAndIconFill(
                name: images[index],
                fromNetWork: true,
                height: width * 1.49,
                width: width * 1.49,);

            },
            autoplay: false,
            loop: false,
            itemCount: images.length,
            control: SwiperControl(size: 0),
          ),
        ),
      ),
    );
  }
}
