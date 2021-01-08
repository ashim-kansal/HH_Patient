import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  static const String RouteName = '/map';

  MapPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.651070, -79.347015),
    zoom: 14.4746,
  );

    return Scaffold(
        appBar: AppBar(
          title: Text("Pharmacies", style: TextStyle(color: Colors.white)),
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
              // padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: GoogleMap(
                          mapType: MapType.terrain,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: _onMapCreated,
                        )
                      ),
        ));
  }
}
