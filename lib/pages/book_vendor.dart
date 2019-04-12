import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

// import './book_vendor_success.dart';
// import './book_vendor_fail.dart';
import './edit_price.dart';
import './wallet.dart';

class BookVendorPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BookVendorPageState();
  }
}

class _BookVendorPageState extends State<BookVendorPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'phone': '',
    'email': '',
    'username': '',
    'password': ''
  };
  String _wastePrice = '0.0';
  final int binPrice = 100;

  TextEditingController _controller = TextEditingController();

  void _onChange(){
    String text = _controller.text;

    if(text.isNotEmpty){
      print(text);
      setState(() {
       _wastePrice =  (double.parse(text) * binPrice).toString();
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_onChange);
    super.initState();
  }

  void _openImagePicker(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: <Widget>[
              customText.TitleText(
                text: 'Add Image',
                textColor: Colors.black,
              ),
              SizedBox(height: 10,),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Use Camera'),
                onTap: (){

                },
              ),
              SizedBox(width: 5,),
              ListTile(
                leading: Icon(Icons.picture_in_picture),
                title: Text('Select from Gallery'),
                onTap: (){

                },
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _fieldsGap = 20;
    final List<String> _wasteTypes = ['Household waste', 'Office waste', 'Sewage', 'Liquid Waste'];
    String _wasteType = _wasteTypes[0];

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book Vendor'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: <Widget>[
                customText.TitleText(
                  text: 'Schedule Pickup',
                  textColor: Colors.black,
                ),
                SizedBox(height: 20,),
                Form(
                  key: _formKey,
                  child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'Waste location',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(Icons.my_location),
                              onTap: (){
                                final SnackBar snackBar = SnackBar(
                                  content: Text('Getting Location'),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            )
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your phone number is required';
                          } else if(!RegExp(r'^[0-9]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid phone number';
                          }
                        },
                        onSaved: (String value){
                          _formData['phone'] = value;
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      // DropdownButtonFormField<String>(
                      //   decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10)
                      //       )
                      //   ),
                      //   value: _wasteType,
                      //   items: _wasteTypes.map<DropdownMenuItem<String>>((String wasteType) => DropdownMenuItem(
                      //     value: wasteType,
                      //     child: Text(wasteType),
                      //   )).toList(),
                      //   onChanged: (String newValue){
                      //     setState(() {
                      //       _wasteType = newValue;
                      //       print(_wasteType);
                      //     });
                      //   },
                      // ),
                      // SizedBox(height: _fieldsGap,),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.delete),
                          labelText: 'Number of Bins',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'This field is required';
                          }
                        },
                        onSaved: (String value){
                          _formData['username'] = value;
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        alignment: Alignment.centerRight,
                        child: customText.BodyText(
                          text: 'NGN ${binPrice.toString()} per bin',
                          textColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 3,),
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                        borderSide: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Price: NGN ' + _wastePrice),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => EditPricePage()
                                ));
                              },
                            )
                          ],
                        ),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EditPricePage()
                          ));
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                        borderSide: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Add Image'),
                            IconButton(
                              icon: Icon(Icons.camera),
                              onPressed: (){
                                _openImagePicker(context);
                              },
                            )
                          ],
                        ),
                        onPressed: (){
                          _openImagePicker(context);
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      RaisedButton(
                        child: customText.BodyText(text: 'Send Offer', textColor: Colors.white,),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => WalletPage(true)
                          ));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}