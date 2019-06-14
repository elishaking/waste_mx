import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class HeadlineText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;
  final double fontSize;

  HeadlineText(
      {this.text,
      this.textColor = Colors.white,
      this.textAlign = TextAlign.left,
      this.fontSize = 33});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w900,
        fontSize: getSize(context, fontSize),
        color: textColor,
        letterSpacing: 1.3,
      ),
      textAlign: textAlign,
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;

  TitleText(
      {this.text,
      this.textColor = Colors.white,
      this.textAlign = TextAlign.left});
    
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.title.merge(TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w900,
        // fontSize: getSize(context, 20),
        color: textColor,
        // letterSpacing: 2,
      ))
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final double fontSize;

  BodyText(
    {
      this.text,
      this.textColor = Colors.white,
      this.textAlign = TextAlign.left,
      this.textOverflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 14
    }
  );

  // double _getTextSize(final double targetWidth) {
  //   // at 1440px width, fontsize = 14
  //   return 0.0027 * targetWidth + 10.136;
  // }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.body1.merge(TextStyle(
        // fontSize: getSize(context, fontSize),
        color: textColor
      )),
      textAlign: textAlign,
      overflow: textOverflow,
    );
  }
}

class LogoTextWhite extends StatelessWidget {
  const LogoTextWhite({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.title.merge(TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
          // fontSize: getSize(context, 20),
          color: Colors.white,
          // letterSpacing: 2,
        )),
        children: [
          TextSpan(
            text: "Waste"
          ),
          TextSpan(
            text: "MX",
            style: TextStyle(
              color: Colors.amber
            )
          )
        ]
      ),
    );
  }
}

class LogoText extends StatelessWidget {
  const LogoText({
    Key key,
  }) : super(key: key);

  static TextSpan textSpan(BuildContext context){
    return TextSpan(
      style: Theme.of(context).textTheme.title.merge(TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w900,
        // fontSize: getSize(context, 20),
        color: Theme.of(context).primaryColor,
        // letterSpacing: 2,
      )),
      children: [
        TextSpan(
          text: "Waste"
        ),
        TextSpan(
          text: "MX",
          style: TextStyle(
            color: Colors.amber
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.title.merge(TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
          // fontSize: getSize(context, 20),
          color: Theme.of(context).primaryColor,
          // letterSpacing: 2,
        )),
        children: [
          TextSpan(
            text: "Waste"
          ),
          TextSpan(
            text: "MX",
            style: TextStyle(
              color: Colors.amber
            )
          )
        ]
      ),
    );
  }
}
