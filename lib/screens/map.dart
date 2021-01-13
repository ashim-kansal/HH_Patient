import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
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
    zoom: 14.4746,
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
              child: GoogleMap(
                          mapType: MapType.terrain,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers),

              )
                      ),
        ));
  }

  void searchNearby() async {
    setState(() {
      markers.clear(); // 2
    });
    // 3
    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/output?key=AIzaSyBgj9olJajssax5PritKjU4oy0li4UYJ5I&location=43.651070,-79.347015&radius=10000&keyword=pharmacies';
    print(url);
    // 4
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      // setState(() {
      //   places = PlaceResponse.parseResults(data['results']);
      //   for (int i = 0; i < places.length; i++) {
      //     markers.add(
      //       Marker(
      //         markerId: MarkerId(places[i].placeId),
      //         position: LatLng(places[i].geometry.location.lat,
      //             places[i].geometry.location.long),
      //         infoWindow: InfoWindow(
      //             title: places[i].name, snippet: places[i].vicinity),
      //         onTap: () {},
      //       ),
      //     );
      //   }
      // });
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    // setState(() {
    //   searching = false; // 6
    // });
  }

}
