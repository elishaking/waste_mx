import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:waste_mx/models/dispose_offering.dart';
import 'package:waste_mx/models/offering.dart';
import 'package:waste_mx/models/transaction.dart';
import 'package:waste_mx/models/user.dart';
import 'package:waste_mx/pages/wallet/transactions.dart';
import 'package:waste_mx/scoped_models/main.dart';

import '../../widgets/custom_text.dart' as customText;

import './payment_confirmed.dart';

class WalletPayPage extends StatelessWidget {
  final MainModel model;
  final double transactionFee = 50;

  WalletPayPage(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay with Wallet'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Wallet Balance'),
                customText.HeadlineText(
                  text: 'N ${model.walletBalance}',
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child:
                      Text('${transactionFee.toString()} NGN transaction fee'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: '${model.currentOfferingAmount}',
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    labelText: 'amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: FlatButton(
                    child: Text('Payment Terms'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: PaymentButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentButton extends StatefulWidget {
  const PaymentButton({
    Key key,
  }) : super(key: key);

  @override
  _PaymentButtonState createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return model.isLoading ? CircularProgressIndicator() : RaisedButton(
            child: customText.BodyText(
            text: 'Pay Securely',
            textColor: Colors.white,
          ),
          onPressed: () {
            final DisposeOffering offer = model.allOfferings[model.currentOfferingType][0];
            model.addTransaction(Transaction(
              amount: double.parse(offer.price),
              type: model.currentOfferingType,
              subType: offer.name,
              initiatedByClient: true,
              initiatedByVendor: false,
              clientDetails: ClientDetails(
                clientId: model.client.id,
                clientName: model.client.name
              ),
              // vendorDetails: VendorDetails(  //todo: add vendor details
              //   vendorId: 
              // ),
              pending: true,
            )).then((bool transactionCreated){
              if(transactionCreated){
                model.updateWalletBalance(-1 * double.parse(offer.price)).then((bool walletUpdated){
                  if(walletUpdated) {
                    model.addEscrow(Escrow(
                      amount: double.parse(offer.price)
                    ));
                    
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => TransactionsPage(model)
                    ), (Route route) => route.isFirst);
                  } else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Error"),
                        content: Text("Something went wrong"),
                      )
                    );
                  }
                });
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("Cannot create Offer at the moment. Please try again"),
                  )
                );
              }
            });

            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (BuildContext context) =>
            //         PaymentConfirmedPage(1000)));
          },
        );
      },
    );
  }
}
