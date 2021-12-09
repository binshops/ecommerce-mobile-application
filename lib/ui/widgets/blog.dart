import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:prestashop_mobile_app/ui/shared/text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:prestashop_mobile_app/ui/widgets/placeholder_builder.dart';
import 'package:flutter/material.dart';

class ImageAndIconFill extends StatefulWidget {
  final String name;
  final Color color;
  final double height;
  final double width;
  final VoidCallback onTap;
  final bool fromNetWork;

  ImageAndIconFill(
      {Key key,
      @required this.name,
      this.color,
      this.height,
      this.width,
      this.onTap,
      this.fromNetWork = false})
      : super(key: key);

  @override
  _ImageAndIconFillState createState() => _ImageAndIconFillState();
}

class _ImageAndIconFillState extends State<ImageAndIconFill> {
  ImageProvider placeholder = AssetImage(Logo);

  @override
  Widget build(BuildContext context) {
    final placeholderBuilder = PlaceholderBuilder.of(context);

    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          height: widget.height,
          width: widget.width,
          child: widget.fromNetWork
              ? NetImage(
                  url: widget.name ?? ' ',
                  fit: BoxFit.fill,
                  key: Key('key ${widget.name}'),
                  keyCache: 'key ${widget.name}',
                  placeholder: placeholderBuilder != null
                      ? placeholderBuilder?.builder()(context)
                      : Image(
                          image: placeholder,
                        ),
                  errorPlaceholder: placeholderBuilder != null
                      ? placeholderBuilder?.errorBuilder()(context)
                      : Image(
                          image: placeholder,
                        ))
              : Image.asset(
                  widget.name ?? ' ',
                  fit: BoxFit.fill,
                  color: widget.color,
                )),
    );
  }
}

class BinshopsCircularIndicator extends StatelessWidget {
  const BinshopsCircularIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width * 0.0426,
        height: width * 0.0426,
        child: CircularProgressIndicator());
  }
}

class ImageBorder extends StatefulWidget {
  final String name;
  final double height;
  final double width;
  final double border;
  final bool fromNetWork;
  final bool borderAll;
  final VoidCallback onTap;

  ImageBorder(
      {Key key,
      this.name,
      this.height,
      this.width,
      this.border,
      this.fromNetWork = false,
      this.onTap,
      this.borderAll = false})
      : super(key: key);

  @override
  _ImageBorderState createState() => _ImageBorderState();
}

class _ImageBorderState extends State<ImageBorder> {
  ImageProvider placeholder = AssetImage(Logo);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final placeholderBuilder = PlaceholderBuilder.of(context);

    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: this.widget.width ?? width,
        height: widget.height,
        child: !widget.fromNetWork
            ? Image.asset(
                widget.name ?? '',
                fit: BoxFit.fill,
              )
            : NetImage(
                url: widget.name ?? ' ',
                fit: BoxFit.fill,
                key: Key('key ${widget.name}'),
                keyCache: 'key ${widget.name}',
                placeholder: placeholderBuilder != null
                    ? placeholderBuilder?.builder()(context)
                    : Image(
                        image: placeholder,
                      ),
                errorPlaceholder: placeholderBuilder != null
                    ? placeholderBuilder?.errorBuilder()(context)
                    : Image(
                        image: placeholder,
                      )),
        decoration: BoxDecoration(
            color: white,
            border:
                Border.all(color: lightGray, width: widget.borderAll ? 1 : 0),
            borderRadius: BorderRadius.circular(widget.border ?? 10)),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}

class NetImage extends StatefulWidget {
  @override
  final Key key;
  final String keyCache;
  final String url;
  final double height;
  final double width;
  final int cacheWidth;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorPlaceholder;

  NetImage({
    this.key,
    @required this.url,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorPlaceholder,
    this.cacheWidth,
    this.keyCache,
  }) : super(key: key);

  @override
  _NetImageState createState() => _NetImageState();
}

class _NetImageState extends State<NetImage> with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      key: widget.key,
      width: widget.height,
      height: widget.width,
      cacheWidth: widget.cacheWidth,
      fit: widget.fit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        Widget renderWidget;

        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            animation.reset();

            renderWidget = widget.placeholder ??
                SizedBox(
                  width: widget.width,
                  height: widget.height,
                );
            break;
          case LoadState.completed:
            if (state.wasSynchronouslyLoaded) {
              renderWidget = ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              );
            } else {
              animation.forward();

              renderWidget = FadeTransition(
                opacity: _fadeInFadeOut,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
              );
            }
            break;
          case LoadState.failed:
            animation.reset();

            renderWidget = widget.errorPlaceholder ??
                Container(
                  color: primaryBinShops,
                  width: widget.width,
                  height: widget.height,
                );
            break;
        }

        return renderWidget;
      },
    );
  }
}
