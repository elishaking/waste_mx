import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Waste MX'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/waste_home.jpg'),
                  colorFilter: ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken
                  ),
                  fit: BoxFit.cover
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
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
                                bottomRight: Radius.circular(0)
                              ),
                            ),
                            child: Text('Search vendor recycler'),
                            onPressed: (){
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
                                bottomRight: Radius.circular(100)
                            ),
                          ),
                          onPressed: (){
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
                    padding: EdgeInsets.only(top: 18, bottom: 0, left: 10, right: 10),
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
                    padding: EdgeInsets.only(top: 5, bottom: 18, left: 10, right: 10),
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
              child: Column(

              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black, width: 0.5)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.home, color: Theme.of(context).accentColor,),
                  Text('Home', style: TextStyle(color: Theme.of(context).accentColor),)
                ],
              ),
              onPressed: (){

              },
            ),
            FlatButton(
              child: Icon(Icons.person),
              onPressed: (){

              },
            ),
            FlatButton(
              child: Icon(Icons.account_balance_wallet),
              onPressed: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
