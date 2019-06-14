import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class RatingDisplay extends StatelessWidget {
  final int rating;

  RatingDisplay({this.rating});

  @override
  Widget build(BuildContext context) {
    final Color fillColor = Theme.of(context).accentColor;
    return IconTheme(
      data: IconThemeData(color: Colors.grey, size: getSize(context, 25)),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          rating > 0
              ? Icon(Icons.star, color: fillColor)
              : Icon(Icons.star_border),
          rating > 1
              ? Icon(Icons.star, color: fillColor)
              : Icon(Icons.star_border),
          rating > 2
              ? Icon(Icons.star, color: fillColor)
              : Icon(Icons.star_border),
          rating > 3
              ? Icon(Icons.star, color: fillColor)
              : Icon(Icons.star_border),
          rating > 4
              ? Icon(Icons.star, color: fillColor)
              : Icon(Icons.star_border),
        ],
      ),
    );
  }
}

class RatingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RatingButtonState();
  }
}

class _RatingButtonState extends State<RatingButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
