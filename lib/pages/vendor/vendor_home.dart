import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';

import '../../widgets/custom_text.dart' as customText;
import '../../models/update.dart';

import '../wallet.dart';
import './offerings.dart';

class VendorHomePage extends StatelessWidget {
  final double pad_vertical = 13.0;

  //* Get data from server
  // final Map<String, List<Map<String, dynamic>>> _wasteOffers = {
  //   'Household waste': [
  //     {'id': '00223s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': '2er2f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': 'qw2s23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //   ],
  //   'Office waste': [
  //     {'id': '222zx3s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': '2wjd2f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': '22pls23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //   ],
  //   'Sewage': [
  //     {'id': '222p3s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': '22f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //     {'id': '22s23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
  //   ]
  // };

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
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
                // Navigator.pushNamed(context, 'profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (BuildContext context) => WalletPage(false)
                // ));
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
            child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model){
                return Row(
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
                        child: Text('View Client Offerings'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => OfferingsPage(model)));
                        },
                      ),
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => OfferingsPage(model)));
                      },
                    )
                  ],
                );
              },
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
              'Get access to clients in need of waste collectors, scavengers, recycling agents/centers, de-clusters, etc',
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

  final List<Update> _messages = [
    Update(
      id: '1',
      icon: Icon(Icons.account_balance_wallet),
      title: 'Earned Coins',
      message: 'You earned 50 points just for installation, check your wallet',
      action: 'WALLET',
    ),
    Update(
      id: '2',
      icon: Icon(Icons.done_all),
      title: 'Transaction Complete',
      message: 'Household Waste disposal',
      action: 'VIEW',
    ),
    Update(
      id: '3',
      icon: Icon(Icons.account_balance_wallet),
      title: 'Earned Coins',
      message: 'You earned 100 points just for installation, check your wallet',
      action: 'WALLET',
    ),
  ];

  Widget _buildMessagesSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: List.generate(
            _messages.length,
            (int index) => Dismissible(
                  key: Key(_messages[index].id),
                  onDismissed: (DismissDirection dir) {
                    _messages.removeAt(index);
                    print(_messages);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: _messages[index].icon,
                            title: Text(_messages[index].title),
                            subtitle: Text(_messages[index].message),
                          ),
                          ButtonTheme.bar(
                            child: ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: Text(_messages[index].action),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
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
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _buildTopSection(context),
              SizedBox(
                height: 20,
              ),
              _buildMessagesSection()
            ],
          ),
        ),
      ),
    );
  }
}
