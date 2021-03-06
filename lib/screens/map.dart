import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GooglePlaceResponse.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'data/place_reposne';


class MapPage extends StatefulWidget {
  static const String RouteName = '/map';

  MapPage({Key key, this.title}) : super(key: key);

  final String title;
  var error = false;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> {
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  List<Marker> markers = <Marker>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchNearby();
  }

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
    zoom: 12,
  );

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).pharmacies, style: TextStyle(color: Colors.white)),
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
              child: Stack(
                children: <Widget>[
                  Container(child: GoogleMap(
                    mapType: MapType.terrain,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: _onMapCreated,
                    markers: Set<Marker>.of(markers),

                  ),),
                  Positioned(top: 10,
                    right: 15,
                    left: 15,
                    child: Container(
                      color: Colors.white,
                    ),
                  )
                ]),

                      ),
        ));
  }

  void searchNearby() async {
    setState(() {
      markers.clear(); // 2
    });
    // 3
    String url =
        'https://maps.googleapis.com/maps/api/place/search/json?location=43.6491341,-79.3567846&radius=50000&types=pharmacy&sensor=true&key=AIzaSyAppg0XMlMz-lT1MhLCZGrs56HrGWuTXKI';
    print(url);
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      GooglePlaceResponse places = googlePlaceResponseFromJson(response.body);
      if(places == null || places.results.length == 0)
        return;

      setState(() {
        for (int i = 0; i < places.results.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places.results[i].placeId),
              position: LatLng(places.results[i].geometry.location.lat,
                  places.results[i].geometry.location.lng),
              infoWindow: InfoWindow(
                  title: places.results[i].name, snippet: places.results[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    // setState(() {
    //   searching = false; // 6
    // });
  }

}
