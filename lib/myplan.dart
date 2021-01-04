import 'package:flutter/material.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_app/widgets/planwidget.dart';
import 'package:flutter_app/api/MyProgramsProvider.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';

class MyPlans extends StatefulWidget {
  static const String RouteName = '/planwidget';

  var isUpdate = false;

  MyPlans({Key key, @required this.isUpdate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyPlansState();
}

class MyPlansState extends State<MyPlans> {
  var pagerController = PageController(
    initialPage: 0,
  );

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = "sk_test_51HpT2LCqtD4cxQPsXTUC40N2Eloiyw91WdjH09qYPUpxmTt2hiXq0vqI13gNWpJ8lqzbsAgR6XHECWE07shIUWG900UDpAxVn3"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  final CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );



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
  @override
  Widget build(BuildContext context) {
    return MyWidget(
        title: HHString.hh,
        child: FutureBuilder<GetProgramsResponse>(
            future: getAllPrograms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                }

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xff707070), fontSize: 16),
                      ),
                    ),
                    Expanded(
                        child: PageView.builder(
                      itemCount: snapshot.data.result.length, // Can be null
                      itemBuilder: (context, position) {
                        return PlanWidget(
                          title: snapshot.data.result[position].title,
                          program_type:
                              snapshot.data.result[position].programType,
                          desc: snapshot.data.result[position].description,
                          price: snapshot.data.result[position].amount,
                          onClick: () {
                            buyNewPlan(snapshot.data.result[position].id,snapshot.data.result[position].amount);


                          },
                        );
                      },
                    )),
                  ],
                );
              } else
                return                Center(child: CircularProgressIndicator());

            })
    );
  }

  void buyNewPlan(String id, String paymentAmount) {

    // StripePayment.createSourceWithParams(SourceParams(
    //   type: 'ideal',
    //   amount: int.parse(paymentAmount),
    //   currency: 'usd',
    //   returnURL: 'example://stripe-redirect',
    // )).then((source) {
    //   print(jsonEncode(source));
    //
    //   StripePayment.createTokenWithCard(
    //      testCard
    //   ).then((token) {
    //     // print('response'+ jsonEncode(token));
    //     print(token.tokenId);
    //     StripePayment.createPaymentMethod(
    //       PaymentMethodRequest(
    //         card: CreditCard(
    //           token: token.tokenId,
    //         ),
    //       ),
    //     ).then((paymentMethod) {
    //
    //       print('response  dd '+ jsonEncode(paymentMethod));
    //       StripePayment.confirmPaymentIntent(
    //         PaymentIntent(
    //           clientSecret: _currentSecret,
    //           paymentMethodId: paymentMethod.id,
    //         ),
    //       ).then((paymentIntent) {
    //         print('response'+ jsonEncode(paymentIntent));
    //       }).catchError((setError) {
    //         print(setError);
    //
    //       });
    //     }).catchError((setError){
    //       print((setError));
    //     });
    //
    //   }).catchError((setError){
    //     print((setError));
    //   });



      buyPlan(id, paymentAmount).then((value) => {
        if(value.responseCode == 200){
          // Navigator.pop(context),
          // if(!widget.isUpdate){
          Navigator.pushNamed(context, QuestionairePage.RouteName, arguments: QuestionaireArguments(id))
          // }

        }
      });

    // }).catchError((error){
    //   print(error);
    // });
  }

}

class MyPlansArguments {
  final bool isUpdate;

  MyPlansArguments(this.isUpdate);
}

