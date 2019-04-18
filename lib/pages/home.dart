import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;
import '../widgets/bottom_navigation_bar.dart';

import './dispose_waste.dart';
import './recycle_waste.dart';
import './wallet.dart';

class HomePage extends StatelessWidget {
  final double pad_vertical = 13.0;

  final List<Map<String, dynamic>> _wasteMXUserOptions = [
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

  final List<Map<String, dynamic>> _messages = [
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Earned Coins',
      'message':
          'You earned 50 points just for installation, check your wallet',
      'action': 'WALLET'
    },
  ];

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/waste_home.jpg'),
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
          //   child: Text(
          //     'You earned 50 points just for installation, check your wallet',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // OutlineButton(
          //   child: Text('Search vendor recycler'),
          // ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
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
                top: pad_vertical, bottom: 0, left: 10, right: 10),
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

  Widget _buildSlidingSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: pad_vertical, horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(
                _wasteMXUserOptions.length,
                (int index) => Card(
                        child: Column(
                      children: <Widget>[
                        Image(
                          width: 130,
                          image: AssetImage(
                              _wasteMXUserOptions[index]['imageUrl']),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: Text(_wasteMXUserOptions[index]['name']),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          _wasteMXUserOptions[index]['page']));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )))),
      ),
    );
  }

  Widget _buildCategoryWidget(
      BuildContext context, String title, String imageUrl,
      [dynamic route]) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: pad_vertical),
      child: Column(
        children: <Widget>[
          Image(
            width: _getSize(110),
            height: _getSize(110),
            image: AssetImage(imageUrl),
          ),
          SizedBox(
            height: 15,
          ),
          customText.BodyText(
            text: title,
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      onPressed: () {
        if (route == null) return;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => route));
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Dispose Waste',
                  'assets/recycling-bin.png', DisposeWastePage()),
              _buildCategoryWidget(context, 'Recycle Waste',
                  'assets/eco-factory.png', RecycleWastePage())
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(
                  context, 'De-clustering', 'assets/target.png'),
              _buildCategoryWidget(context, 'Sewage', 'assets/sewage.png')
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Upcycling', 'assets/creative.png'),
              _buildCategoryWidget(
                  context, 'Info Center', 'assets/analysis.png')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: List.generate(
            _messages.length,
            (int index) => Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(_messages[index]['icon']),
                          title: Text(_messages[index]['title']),
                          subtitle: Text(_messages[index]['message']),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: Text(_messages[index]['action']),
                                onPressed: () {},
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              width: _targetWidth,
              color: Theme.of(context).primaryColor,
              //  child: CircleAvatar(
              //    child: Image(image: AssetImage('assets/profile.png'), fit: BoxFit.fill,),
              //  ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
              selected: true,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WalletPage(false)));
                //  Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Shop'),
              onTap: () {
                Navigator.pop(context);
                //  Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Vendors'),
              onTap: () {
                Navigator.pop(context);
                //  Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.markunread_mailbox),
              title: Text('Packages'),
              onTap: () {
                Navigator.pop(context);
                //  Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.label_outline),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('welcome', (Route route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: _buildDrawer(context),
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
            // _buildBottomSection(),
            _buildCategoriesSection(context),
            // SizedBox(height: 20,),
            // _buildMessagesSection()
          ],
        ),
      ),
      bottomNavigationBar: ButtomNavigationBar('home'),
    );
  }
}
