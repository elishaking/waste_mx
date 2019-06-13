import 'package:flutter/material.dart';

class UnusedWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double pad_vertical = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Unused widgets'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/waste_home.jpg'),
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.darken),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: pad_vertical),
                          child: Text(
                            'You earned 50 points just for installation, check your wallet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //                  OutlineButton(
                        //                    child: Text('Search vendor recycler'),
                        //                  ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: pad_vertical),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(vertical: 13.5),
                                  color: Colors.white,
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                        topRight: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  child: Text('Search vendor recycler'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'search');
                                  },
                                ),
                              ),
                              FlatButton(
                                child: Icon(Icons.search),
                                color: Theme.of(context).accentColor,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100)),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'search');
                                },
                              )
                            ],
                          ),
                          /*TextField(
                              onTap: () => Navigator.pushNamed(context, 'search'),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Search vendor recycler',
                                  suffixIcon: Icon(Icons.search)
                              ),
                            )*/
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              top: pad_vertical,
                              bottom: 0,
                              left: 10,
                              right: 10),
                          child: Text(
                            'Make money with waste',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              top: 5, bottom: 18, left: 10, right: 10),
                          child: Text(
                            'Get access to waste collectors, scavengers, recycling agents/centers, de-clusters, etc',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: pad_vertical, horizontal: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Dispose Waste'),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'dispose_waste');
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Recycle Waste'),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('De-cluster'),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Upcycling'),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Downcycling'),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Image(
                                width: 130,
                                image: AssetImage('assets/dispose.jpg'),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Info Center'),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
