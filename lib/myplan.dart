
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/enroll_service.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/MyProgramsProvider.dart';
import 'package:flutter_app/model/GetProgramsResponse.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/payment.dart';
import 'package:flutter_app/screens/questionaire.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_app/widgets/planwidget.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:toast/toast.dart';

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


  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
        title: AppLocalizations.of(context).hh,
        child: FutureBuilder<GetProgramsResponse>(
            future: getAllPrograms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(AppLocalizations.of(context).error),);
                }

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Text(
                        '',
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
                            price: snapshot.data.result[position].amount.toString(),
                            onClick: () {
                              if(snapshot.data.result[position].amount.compareTo(0) != 1){
                                buyNewPlan(snapshot.data.result[position].id, snapshot.data.result[position].amount.toString());
                                return;
                              }
                              Navigator.pushNamed(context, Payment.RouteName, arguments: PaymentArguments(snapshot.data.result[position], widget.isUpdate));
                            //  buyNewPlan(snapshot.data.result[position].id,snapshot.data.result[position].amount);
                            },
                          );
                        },
                      ) ,
                    ),
                  ],
                );
              } else
                return Center(child: CircularProgressIndicator());

            })
    );
  }

  void buyNewPlan(String id, String paymentAmount) {

    buildShowDialog(context);

    APIService apiService = new APIService();
    // ignore: sdk_version_set_literal
      apiService.buyPlanAPIHandler("", id, paymentAmount).then((value) => {
        Navigator.of(context).pop(),
        Timer(Duration(seconds: 1), ()=> {
          showToast(value.responseMsg),

          Navigator.pop(context),
         
          Navigator.pushNamed(context, QuestionairePage.RouteName, arguments: QuestionaireArguments(id))
          
        }),
      });
  }

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

}

class MyPlansArguments {
  final bool isUpdate;

  MyPlansArguments(this.isUpdate);
}

