import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/api/API_services.dart';
import 'package:flutter_app/model/LibraryModel.dart';
import 'package:flutter_app/screens/ViewerPage.dart';
import 'package:flutter_app/screens/map.dart';
import 'package:flutter_app/utils/allstrings.dart';
import 'package:flutter_app/utils/colors.dart';
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:native_video_view/native_video_view.dart';
import 'package:simple_moment/simple_moment.dart';

class LibraryPage extends StatefulWidget {
  static const String RouteName = '/library';
  final docs = [
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
    'abcd',
  ];

  LibraryPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FutureBuilder<LibraryList>(
                  future: getLibraryList(),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(AppLocalizations.of(context).error),
                        );
                      }
                      return GridView.builder(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          itemCount: snapshot.data.result.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          // crossAxisCount: 2,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          // Generate 100 widgets that display their index in the List.
                          itemBuilder: (BuildContext context, int index) {
                            print(snapshot.data.result[index].document);
                            // var date = snapshot.data.result[index].createdAt;
                            var _date = snapshot.data.result[index].createdAt;
                            Moment createdDate = Moment.parse('$_date');
                            createdDate.format("dd/MM/yyyy hh:mm a");
                            return Card(
                              elevation: 10,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.fromLTRB(15, 15, 15, 7),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        snapshot.data.result[index].document
                                                .endsWith('.mp3')
                                            ? 'assets/images/audion.png'
                                            : snapshot
                                                    .data.result[index].document
                                                    .endsWith('.mp4')
                                                ? 'assets/images/video.png'
                                                : snapshot.data.result[index]
                                                        .document
                                                        .endsWith('.pdf')
                                                    ? 'assets/images/pdf.png'
                                                    : 'assets/images/ic_doc.png',
                                        height: 30,
                                        width: 40,
                                      ),
                                      Text(
                                        snapshot.data.result[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: HH_Colors.grey_585858,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'By ' +
                                            snapshot
                                                .data.result[index].uploadBy +
                                            " " +
                                            createdDate
                                                .format("dd/MM/yyyy HH:mm a"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: HH_Colors.accentColor),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (snapshot
                                                  .data.result[index].document
                                                  .endsWith('.mp3') ||
                                              snapshot
                                                  .data.result[index].document
                                                  .endsWith('.mp4')) {
                                            showFileInDialog(snapshot
                                                .data.result[index].document);
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewerPage(
                                                          url: snapshot
                                                              .data
                                                              .result[index]
                                                              .document,
                                                        )));
                                          }
                                        },
                                        child: Card(
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .open,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "ProximaNova",
                                                    color: Colors.white),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: HH_Colors.accentColor,
                                            ),
                                          ),
                                          elevation: 10,
                                        ),
                                      )
                                      // HHButton(title: 'Download', type: 4, isEnable: true, textSize: 18)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                      // );
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: HHButton(
                title: AppLocalizations.of(context).search_pharma,
                type: 1,
                isEnable: true,
                textSize: 18,
                onClick: () {
                  Navigator.pushNamed(context, MapPage.RouteName);
                },
              ),
            ),
          ],
        ));
  }

  void showFileInDialog(String document) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.topRight,
                      height: 25,
                      child: FlatButton(
                        color: Colors.white,
                        child: Icon(
                          Icons.clear,
                          color: HH_Colors.accentColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: CircleBorder(
                            side: BorderSide(
                                color: HH_Colors.color_EEDDDD, width: 1)),
                      )),
                  // Expanded(child: videoView(document))
                ],
              ),
            ),
          );
          // return videoView(document);
        });
  }

  // Widget videoView(String document) {
  //   return NativeVideoView(
  //     keepAspectRatio: false,
  //     showMediaController: true,
  //     onCreated: (controller) {
  //       controller.setVideoSource(
  //         document,
  //         sourceType: VideoSourceType.network,
  //       );
  //     },
  //     onPrepared: (controller, info) {
  //       controller.play();
  //     },
  //     onError: (controller, what, extra, message) {
  //       print('Player Error ($what | $extra | $message)');
  //     },
  //     onCompletion: (controller) {
  //       print('Video completed');
  //     },
  //     onProgress: (progress, duration) {
  //       print('$progress | $duration');
  //     },
  //   );
  // }
}
