import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './dispose_waste.dart';

class HomePage extends StatelessWidget {
  final double pad_vertical = 13.0;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> wasteMXUserOptions = [
      {
        'name': 'Dispose Waste',
        'imageUrl': 'assets/dispose.jpg',
        'summary': 'Get rid of waste with ease',
        'page': DisposeWastePage()
      },
      {
        'name': 'Recycle Waste',
        'imageUrl': 'assets/dispose.jpg',
        'summary': 'Make money from recycling waste',
        'page': DisposeWastePage()
      },
      {
        'name': 'Dispose Waste',
        'imageUrl': 'assets/dispose.jpg',
        'summary': 'Get rid of waste with ease',
        'page': DisposeWastePage()
      },
    ];

    Widget _buildTopSection(BuildContext context){
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/waste_home.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken
            ),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
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
              padding: EdgeInsets.only(top: pad_vertical, bottom: 0, left: 10, right: 10),
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
      );
    }

    Widget _buildDrawer(){
      return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 230,
                width: deviceWidth,
                color: Theme.of(context).primaryColor,
//                child: CircleAvatar(
//                  child: Image(image: AssetImage('assets/profile.png'), fit: BoxFit.fill,),
//                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: (){
                  Navigator.pop(context);
                },
                selected: true,
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text('Wallet'),
                onTap: (){
                  Navigator.pop(context);
//                  Navigator.pushNamed(context, 'profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Shop'),
                onTap: (){
                  Navigator.pop(context);
//                  Navigator.pushNamed(context, 'profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text('Vendors'),
                onTap: (){
                  Navigator.pop(context);
//                  Navigator.pushNamed(context, 'profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.markunread_mailbox),
                title: Text('Packages'),
                onTap: (){
                  Navigator.pop(context);
//                  Navigator.pushNamed(context, 'profile');
                },
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text('Waste MX'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, 'search');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopSection(context),
            GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              children: List.generate(wasteMXUserOptions.length, (index) {
                return Container(
                  decoration: BoxDecoration(

                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          alignment: Alignment.centerLeft,
                          child: Image.asset(wasteMXUserOptions[index]['imageUrl']),
                        ),
                      ),
                      SizedBox(height: 20,),
                      customText.BodyText(
                        text: wasteMXUserOptions[index]['summary'],
                        textColor: Theme.of(context).primaryColor,
                        textAlign: TextAlign.center,
                      ),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text(wasteMXUserOptions[index]['name'],),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => wasteMXUserOptions[index]['page']
                                ));
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  )
                );
              }),
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
                Navigator.pushNamed(context, 'profile');
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
