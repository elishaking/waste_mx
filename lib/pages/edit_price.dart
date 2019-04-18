import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class EditPricePage extends StatefulWidget {
  final defaultPrice;

  EditPricePage(this.defaultPrice);

  @override
  State<StatefulWidget> createState() {
    return _EditPricePageState();
  }
}

class _EditPricePageState extends State<EditPricePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'price': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Price'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Center(
          child: Column(
            children: <Widget>[
              customText.TitleText(
                text:
                    'Vendors are more likely to accept offers within their set rate',
                textColor: Theme.of(context).accentColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        labelText: 'Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      initialValue: widget.defaultPrice,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                      },
                      onSaved: (String value) {
                        _formData['price'] = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: customText.BodyText(
                        text: 'Set',
                        textColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pop(context, _formData['price']);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
