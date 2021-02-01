import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/MyScaffoldWidget.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:native_video_view/native_video_view.dart';

class ViewerPage extends StatelessWidget{

  String url = '';

  ViewerPage({this.url});


  @override
  Widget build(BuildContext context) {
    return MyWidget(title: 'View', child: getWidget(url, context));
  }

  getWidget(String url, BuildContext context) {
    if(url.endsWith('.pdf') || url.endsWith('.doc')){
      return pdfView(context, url);
    }
    if(url.endsWith('.mp4') || url.endsWith('.mp3')){
      return Container();
    }
  }

  // Widget videoView(String document) {
  //   return Center(child: NativeVideoView(
  //     keepAspectRatio: true,
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
  //   ),);
  // }

  Widget pdfView(BuildContext  context, String document) {
    print(document);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const PDF(
      ).cachedFromUrl(
        document,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );



  }
}