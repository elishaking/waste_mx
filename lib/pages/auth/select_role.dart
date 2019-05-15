import 'package:flutter/material.dart';

import '../../models/user.dart';

import '../../utils/assets.dart';
import '../../utils/responsive.dart';

import '../../widgets/custom_text.dart' as customText;

import './signup.dart';

class SelectRolePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectRolePageState();
  }
}

class _SelectRolePageState extends State<SelectRolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: EdgeInsets.symmetric(
        //     vertical: 10,
        //   ),
        //   child: Image(image: AssetImage('assets/logo.png')),
        // ),
        title: Text('Waste MX'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage(ImageAssets.logo),
                height: getSize(context, 150),
              ),
              SizedBox(height: getSize(context, 70),),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.title.merge(TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w100,
                    )),
                    children: [
                      TextSpan(text: 'How would you like to use '),
                      TextSpan(text: 'WasteMX', style: TextStyle(fontWeight: FontWeight.w700))
                    ]
                  ),
                ),
              ),
              OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  title: Text('Continue as User'),
                  subtitle: Text('I am a household/office I have waste to dispose/recycle/declust'),
                  // selected: _clientSelected,
                  // onTap: () {
                  //   setState(() {
                  //     _clientSelected = true;
                  //     _vendorSelected = false;
                  //   });
                  // },
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => SignUpPage(UserType.Client)
                    ), 
                    (Route route) => false
                  );
                },
              ),
              Divider(),
              OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListTile(
                  title: Text('Continue as Vendor'),
                  subtitle: Text('I am a waste collector/recycler'),
                  // selected: _vendorSelected,
                  // onTap: () {
                  //   setState(() {
                  //     _vendorSelected = true;
                  //     _clientSelected = false;
                  //   });
                  // },
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => SignUpPage(UserType.Vendor)
                    ), 
                    (Route route) => false
                  );
                },
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 30),
              //   child: RaisedButton(
              //     child: Text('Next'),
              //     textColor: Colors.white,
              //     onPressed: () {
              //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              //           builder: (BuildContext context) => SignUpPage(
              //               _clientSelected
              //                   ? UserType.Client
              //                   : UserType.Vendor)), (Route route) => false);
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
