import 'package:prestashop_mobile_app/ui/shared/colors.dart';
import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class BinshopsExpansionTileCategory extends StatefulWidget {
  const BinshopsExpansionTileCategory(
      {Key key,
      this.leading,
      @required this.title,
      this.subtitle,
      this.backgroundColor,
      this.onExpansionChanged,
      this.children = const <Widget>[],
      this.trailing,
      this.initiallyExpanded = false,
      this.maintainState = false,
      this.tilePadding,
      this.expandedCrossAxisAlignment,
      this.expandedAlignment,
      this.childrenPadding,
      this.padding,
      this.paddingDivider,
      this.heightDivider})
      : assert(initiallyExpanded != null),
        assert(maintainState != null),
        assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
        ),
        super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  final Color backgroundColor;

  final bool initiallyExpanded;

  final bool maintainState;

  final EdgeInsetsGeometry tilePadding;

  final Alignment expandedAlignment;

  final CrossAxisAlignment expandedCrossAxisAlignment;

  final EdgeInsetsGeometry childrenPadding;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry paddingDivider;
  final double heightDivider;

  final Widget trailing;

  @override
  _BinshopsExpansionTileCategoryState createState() =>
      _BinshopsExpansionTileCategoryState();
}

class _BinshopsExpansionTileCategoryState
    extends State<BinshopsExpansionTileCategory>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: ListTileTheme.merge(
              iconColor: _iconColor.value,
              textColor: _headerColor.value,
              child: ListTile(
                  onTap: _handleTap,
                  contentPadding: widget.tilePadding,
                  leading: widget.leading,
                  title: widget.title,
                  subtitle: widget.subtitle,
                  trailing: widget.trailing),
            ),
          ),
          widget.heightDivider != null
              ? Padding(
                  padding: widget.paddingDivider ?? EdgeInsets.zero,
                  child: Divider(
                    height: widget.heightDivider ?? 0,
                    color: lightGray,
                  ),
                )
              : Container(),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
        child: TickerMode(
          child: Padding(
            padding: widget.childrenPadding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: widget.expandedCrossAxisAlignment ??
                  CrossAxisAlignment.center,
              children: widget.children,
            ),
          ),
          enabled: !closed,
        ),
        offstage: closed);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
