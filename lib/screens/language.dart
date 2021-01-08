import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/api/SettingService.dart';
import 'package:flutter_app/model/GetBookingSlotsResponse.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:toast/toast.dart';

class LanguagePage extends StatefulWidget {
  static const String RouteName = '/select_anguage';
  
  String languagedata;

  LanguagePage({Key key, @required this.languagedata}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  bool english = false;
  bool french = false;
  bool spanish = false;
  String selectedLang = "";

  @override
  void initState() {
    super.initState();
    selectedLang = widget.languagedata;
    // english = true;
    // french = true;
    // spanish = true;
  }

  void changeLanguage (String lang){
    SettingAPIService settingAPIService = new SettingAPIService();

    settingAPIService.UpdateLanguage(lang).then((value) => {
      if(value.responseCode == 200){
        showToast(value.responseMessage),
        print(lang),
        print(lang == 'en' ? 'US' : lang == 'es' ? 'AR' : 'fr_FR'),
        AppLocalizations.load(Locale(lang, ''))
        }
    });
  }

  //show Toast
  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) => MyWidget(
      title: AppLocalizations.of(context).select_language,
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('English',
                        style: TextStyle(
                            fontSize: 16,
                            color: HH_Colors.grey_35444D,
                            fontFamily: "ProximaNova")),
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: this.selectedLang == "EN" ? true : false,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          selectedLang = "EN";
                        });
                        AppLocalizations.load(Locale('en', 'US'));

                        this.changeLanguage("EN");

                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Français',
                        style: TextStyle(
                            fontSize: 16,
                            color: HH_Colors.grey_35444D,
                            fontFamily: "ProximaNova")),
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: this.selectedLang == "FR" ? true : false,
                      // this.french,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          selectedLang = "FR";
                        });
                        AppLocalizations.load(Locale('fr', 'fr_FR'));

                        this.changeLanguage("FR");
                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('Español',
                      style: TextStyle(
                          fontSize: 16,
                          color: HH_Colors.grey_35444D,
                          fontFamily: "ProximaNova")),
                ]),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Checkbox(
                      value: this.selectedLang == "ES" ? true : false,
                      activeColor: HH_Colors.color_17AB35,
                      onChanged: (value) {
                        setState(() {
                          selectedLang = "ES";
                        });
                        AppLocalizations.load(Locale('es', 'AR'));
                        this.changeLanguage("ES");
                      },
                    ))
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: HH_Colors.grey_707070,
            height: 0.5,
          ),
        ],
      ));


}

class LanguageArguments {
  final String language;

  LanguageArguments(this.language);
}
