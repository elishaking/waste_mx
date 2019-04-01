import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './book_vendor_success.dart';

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

  TextEditingController _controller = TextEditingController();

  void _onChange(){
    String text = _controller.text;

    if(text.isNotEmpty){
      print(text);
      setState(() {
       _wastePrice =  (double.parse(text) * 1.5).toString();
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_onChange);
    super.initState();
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
            padding: EdgeInsets.symmetric(horizontal: 18),
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        value: _wasteType,
                        items: _wasteTypes.map<DropdownMenuItem<String>>((String wasteType) => DropdownMenuItem(
                          value: wasteType,
                          child: Text(wasteType),
                        )).toList(),
                        onChanged: (String newValue){
                          setState(() {
                            _wasteType = newValue;
                            print(_wasteType);
                          });
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.line_weight),
                            labelText: 'Estimated weight',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.number,
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
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                        borderSide: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Price: ' + _wastePrice),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){

                              },
                            )
                          ],
                        ),
                        onPressed: (){
                          
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
                            Text('Upload Image'),
                            IconButton(
                              icon: Icon(Icons.camera),
                              onPressed: (){

                              },
                            )
                          ],
                        ),
                        onPressed: (){
                          
                        },
                      ),
                      SizedBox(height: _fieldsGap,),
                      RaisedButton(
                        child: customText.BodyText(text: 'Send Offer', textColor: Colors.white,),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => BookVendorSuccessPage()
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