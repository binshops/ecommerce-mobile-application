import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final TextAlign textAlign;
  final TextOverflow overflow;

  const TextView(
      {Key key, this.text, this.textStyle, this.onTap, this.textAlign, this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Text(
          text ?? '',
          style: textStyle,
          textAlign: textAlign,
          overflow: overflow,
        ),
      ),
    );
  }
}
