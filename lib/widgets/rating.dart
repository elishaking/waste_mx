import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final int rating;

  RatingDisplay({this.rating});

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

    final Color fillColor = Theme.of(context).accentColor;
    return IconTheme(
      data: IconThemeData(color: Colors.grey, size: _getSize(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
