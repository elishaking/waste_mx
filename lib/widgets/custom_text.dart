import 'package:flutter/material.dart';

class TitleText extends StatelessWidget{
  final String text;
  final Color textColor;

  TitleText({this.text, this.textColor = Colors.white});

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
          letterSpacing: 2
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget{
  final String text;
  final Color textColor;
  final TextAlign textAlign;

  BodyText({this.text, this.textColor = Colors.white, this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1, bottom: 3),
      child: Text(text,
        style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 14,
            color: textColor
        ),
        textAlign: textAlign,
      ),
    );
  }
}