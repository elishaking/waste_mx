import 'package:flutter/material.dart';

class WasteDetailsPage extends StatelessWidget {
  final Map<String, dynamic> wasteListItem;

  WasteDetailsPage(this.wasteListItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Details'),
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(wasteListItem['type']),
                background: Hero(
                  tag: wasteListItem['id'],
                  child: FadeInImage(
                    placeholder:
                        AssetImage('assets/organic.png'), // !some placeholder
                    image: AssetImage(wasteListItem['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate([]),
          )
        ],
      ),
    );
  }
}
