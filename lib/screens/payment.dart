import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/model/MyPlanResponse.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:toast/toast.dart';

class Payment extends StatefulWidget {
  static const String RouteName = '/payment';

  var plan;
  Payment({Key key, this.title, this.plan}) : super(key: key);

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
            // publishableKey:"pk_test_51HpT2LCqtD4cxQPsFF7QxxGBIrDz3Y9e8Obc1zfdtuZLn3AePI5hbHUKS6zqYxalohLN3TSgrUvUe2tolkH8fuEf00p9PQAOi3",
            publishableKey:"pk_test_51HhEk0C7sEeqzqBbdfjgVA5MKi0cmkak1D5VeGpYLTNNlCMc9CQBOfMnYgotIxs5KiX7SL5CG2GeEU9xf80jrT7S00e7vwZuxP",
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
    // var cvv = cvvController.text;

    if(nameoncard.trim().length == 0 || cardnum.trim().length == 0 || month.trim().length == 0 || year.trim().length == 0 ){
      setState(() {
        nameerr = nameoncard.trim().length == 0 ? true : false;
        cardnumerr = cardnum.trim().length == 0 ? true : false;
        mmerr = month.trim().length == 0 ? true : false;
        yyerr = year.trim().length == 0 ? true : false;
        // cvverr = cvv.trim().length == 0? true: false;
      });
      return;
    }
    
    buildShowDialog(context);

    var card = CreditCard(
      number: cardnum,
      expMonth: int.tryParse(month),
      expYear: int.tryParse(year),
    );

    APIService apiService = new APIService();
    // ignore: sdk_version_set_literal
    StripePayment.createTokenWithCard(card).then((value) => {
    
      apiService.buyPlanAPIHandler(value.tokenId, widget.plan.id, widget.plan.amount).then((value) => {
        Navigator.of(context).pop(),
        Timer(Duration(seconds: 1),
        ()=> {
          showToast(value.responseMsg),
           // ignore: sdk_version_ui_as_code
           if(value.responseCode == 200){
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return DialogWithImage(
                    title: "Payment Done!",
                    content: "You have successfully subscribed with "+widget.plan.title,
                    imageSrc: "assets/images/success.png",
                    onClick: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, QuestionairePage.RouteName, arguments: QuestionaireArguments(widget.plan.id));
                    }
                  );
                },
              ).then( (value) {
                if (value == null) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, QuestionairePage.RouteName, arguments: QuestionaireArguments(widget.plan.id));
                  return;
                }
              },
            )
           }
        }),
      
       
      }),
      print(value.tokenId),

    }).catchError((error) => {
      // print(error),
      showToast(error),
    });
  }

    // show circular 
  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child:CircularProgressIndicator(),
          );
      });
  }

  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
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
                                Container(
                                  padding: EdgeInsets.only(top: 20, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: HHTextView(
                                              title: "Total payable amount",
                                              size: 19,
                                              textweight: FontWeight.w800,
                                              color: HH_Colors.color_3D3D3D,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: HHTextView(
                                              title: widget.plan.amount,
                                              size: 19,
                                              textweight: FontWeight.w800,
                                              color: HH_Colors.purpleColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: new GestureDetector(
                                          child: Image.asset('assets/images/penciledit.png', height: 20, width: 20, ),
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      )
                                    ],
                                  )
                                ),
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
                                        hint: "John",
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
                                        hint: "0000 0000 0000 0000",
                                        obscureText: false,
                                        controller: cardController,
                                        error: cardnumerr,
                                        maxLength: 20,
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
                                            maxLength: 2,
                                            errorText:
                                                'Please enter expiry month',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          // padding: EdgeInsets.only(top: 10),
                                          child: HHEditText(
                                            hint: "YY",
                                            obscureText: false,
                                            controller: yyController,
                                            error: yyerr,
                                            maxLength: 2,
                                            errorText:
                                                'Please enter a expiry year',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Column(
                                //   children: [
                                //     Container(
                                //     padding: EdgeInsets.only(top: 15),
                                //     alignment: Alignment.topLeft,
                                //     child:  HHTextView(
                                //         title: "Security Code", 
                                //         textweight: FontWeight.w600, 
                                //         size: 16,
                                //         color: HH_Colors.color_343333,
                                //         alignment: TextAlign.left),),
                                    
                                //     Padding(
                                //       padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                                //       child: HHEditText(
                                //         hint: "Security Code",
                                //         obscureText: false,
                                //         controller: cvvController,
                                //         error: cvverr,
                                //         errorText:
                                //             'Please enter a security code',
                                //       ),
                                //     )

                                //   ],
                                // ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 30, 2, 15),
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

class PaymentArguments {
  var plan;

  PaymentArguments(this.plan);
}
