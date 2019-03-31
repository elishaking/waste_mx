import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget{
  final int rating;

  RatingDisplay({this.rating});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
          color: Colors.grey,
          size: 20
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          rating > 0 ? Icon(Icons.star,) : Icon(Icons.star_border),
          rating > 1 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 2 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 3 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 4 ? Icon(Icons.star) : Icon(Icons.star_border),
        ],
      ),
    );
  }
}

class RatingButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RatingButtonState();
  }
}

class _RatingButtonState extends State<RatingButton>{
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}