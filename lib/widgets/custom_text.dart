import 'package:flutter/material.dart';

class TitleText extends StatelessWidget{
  final String text;
  final Color textColor;
  final TextAlign textAlign;

  TitleText({this.text, this.textColor = Colors.white, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18, bottom: 5),
      child: Text(text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: textColor,
          letterSpacing: 2,
        ),
        textAlign: textAlign,
      ),
    );
  }
}

class BodyText extends StatelessWidget{
  final String text;
  final Color textColor;
  final TextAlign textAlign;

  BodyText({this.text, this.textColor = Colors.white, this.textAlign = TextAlign.left});

  double _getTextSize(final double targetWidth){
    // at 1440px width, fontsize = 14
    return 0.0027 * targetWidth + 10.136;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1, bottom: 3),
      child: Text(text,
        style: TextStyle(
            fontFamily: 'Lato',
            fontSize: _getTextSize(MediaQuery.of(context).size.width),
            color: textColor
        ),
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}