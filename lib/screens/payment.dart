import 'package:flutter/material.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Payment extends StatefulWidget {
  static const String RouteName = '/payment';

  Payment({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  bool nameerr = false;
  bool cardnumerr = false;
  bool mmerr = false;
  bool yyerr = false;
  bool cvverr = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey:"pk_test_51HpT2LCqtD4cxQPsFF7QxxGBIrDz3Y9e8Obc1zfdtuZLn3AePI5hbHUKS6zqYxalohLN3TSgrUvUe2tolkH8fuEf00p9PQAOi3",
            //YOUR_PUBLISHABLE_KEY
            merchantId: "Test",//YOUR_MERCHANT_ID
            androidPayMode: 'test'
        ));
    super.initState();
  }
  
  void payNowHandler() async {
    var nameoncard = nameController.text;
    var cardnum = cardController.text;
    var month = mmController.text;
    var year = yyController.text;
    var cvv = cvvController.text;

    if(nameoncard.trim().length == 0 || cardnum.trim().length == 0 || month.trim().length == 0 || year.trim().length == 0 || cvv.trim().length == 0){
      setState(() {
        nameerr = nameoncard.trim().length == 0 ? true : false;
        cardnumerr = cardnum.trim().length == 0 ? true : false;
        mmerr = month.trim().length == 0 ? true : false;
        yyerr = year.trim().length == 0 ? true : false;
        cvverr = cvv.trim().length == 0? true: false;
      });
      return;
    }

    var card = CreditCard(
      number: cardnum,
      expMonth: int.tryParse(month),
      expYear: int.tryParse(year),
    );

    StripePayment.createTokenWithCard(card).then((value) => {
      print(value.tokenId),
      print(value.card),
      print(value.bankAccount)
    }).catchError((error) => {
      print(error),
    });

  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,

        ),

        body: Material(
          color: Theme.of(context).accentColor,
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Material(
                     child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        color: Colors.white,
                        child: Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      alignment: Alignment.topLeft,
                                      child:  HHTextView(
                                        title: "Name on Card", 
                                        textweight: FontWeight.w600, 
                                        size: 16,
                                        color: HH_Colors.color_343333,
                                        alignment: TextAlign.left),),
                                     Padding(
                                      padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                                      child: HHEditText(
                                        hint: "Name on Card",
                                        obscureText: false,
                                        controller: nameController,
                                        error: nameerr,
                                        errorText:
                                            'Please enter a name on card',
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      alignment: Alignment.topLeft,
                                      child:  HHTextView(
                                          title: "Card Number", 
                                          textweight: FontWeight.w600, 
                                          size: 16,
                                          color: HH_Colors.color_343333,
                                          alignment: TextAlign.left),),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                                      child: HHEditText(
                                        hint: "Card Number",
                                        obscureText: false,
                                        controller: cardController,
                                        error: cardnumerr,
                                        errorText:
                                            'Please enter a valid card number',
                                      ),
                                    ),
                                  ],
                                ),
                                
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 15, bottom: 10),
                                      alignment: Alignment.topLeft,
                                      child:  HHTextView(
                                          title: "Expiration Date", 
                                          textweight: FontWeight.w600, 
                                          size: 16,
                                          color: HH_Colors.color_343333,
                                          alignment: TextAlign.left),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          // padding: EdgeInsets.only(top: 10),
                                          child: HHEditText(
                                            hint: "MM",
                                            obscureText: false,
                                            controller: mmController,
                                            error: mmerr,
                                            errorText:
                                                'Please enter expiry month',
                                          ),
                                        ),
                                        Expanded(
                                          // padding: EdgeInsets.only(top: 10),
                                          child: HHEditText(
                                            hint: "YY",
                                            obscureText: false,
                                            controller: yyController,
                                            error: yyerr,
                                            errorText:
                                                'Please enter a expiry year',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                    padding: EdgeInsets.only(top: 15),
                                    alignment: Alignment.topLeft,
                                    child:  HHTextView(
                                        title: "Security Code", 
                                        textweight: FontWeight.w600, 
                                        size: 16,
                                        color: HH_Colors.color_343333,
                                        alignment: TextAlign.left),),
                                    
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                                      child: HHEditText(
                                        hint: "Security Code",
                                        obscureText: false,
                                        controller: cvvController,
                                        error: cvverr,
                                        errorText:
                                            'Please enter a security code',
                                      ),
                                    )

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                                  child: HHButton(
                                    title: "Pay Now",
                                    isEnable: true,
                                    type: 4,
                                    onClick: () {
                                      payNowHandler();
                                    },
                                  ),
                                ),
                              ]),
                            )
                      ),
                  ),
                  
                ],
              )),
        ));
  }
}
