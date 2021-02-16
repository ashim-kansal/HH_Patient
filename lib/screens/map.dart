import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_localization.dart';
import 'package:flutter_app/model/GooglePlaceResponse.dart' as mLocation;
import 'package:flutter_app/model/GooglePlaceIdResponse.dart' as mLocationDetail;
import 'package:flutter_app/widgets/mywidgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart' ;
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';


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
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  showToast(String message){
    Toast.show(message, 
    context, 
    duration: Toast.LENGTH_LONG, 
    gravity:  Toast.BOTTOM);
  }

  getLocation() async{

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.getLocation().then((value) => {
      setState((){
        _locationData = value;

      }),
      print(value),
      searchNearby()
    });

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
    target: LatLng(_locationData.latitude??0.0, _locationData.longitude??0.0),
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
                    initialCameraPosition: _locationData!=null?_kGooglePlex:null,
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
        'https://maps.googleapis.com/maps/api/place/search/json?location='+_locationData.latitude.toString()+','+_locationData.longitude.toString()+'&radius=50000&types=pharmacy&sensor=true&key=AIzaSyAppg0XMlMz-lT1MhLCZGrs56HrGWuTXKI';
    print(url);
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      mLocation.GooglePlaceResponse places = mLocation.googlePlaceResponseFromJson(response.body);
      if(places == null || places.results.length == 0)
        return;

      setState(() {
        markers.add(Marker(
            markerId: MarkerId("aa"),
            position: LatLng(_locationData.latitude,
                _locationData.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(title: "Mu Location")
        )
        );
        for (int i = 0; i < places.results.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places.results[i].placeId),
              position: LatLng(places.results[i].geometry.location.lat,
                  places.results[i].geometry.location.lng),
              // infoWindow: InfoWindow(
              //     title: places.results[i].name, snippet: places.results[i].vicinity),
              onTap: () {
                getPlaceDetail(places.results[i].placeId);
              },
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

  void getPlaceDetail(String placeId) async {

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid='+placeId+'&key=AIzaSyAppg0XMlMz-lT1MhLCZGrs56HrGWuTXKI';
    print(url);
    final response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(response.body);
      mLocationDetail.GooglePlaceIdResponse placeDetail = mLocationDetail.googlePlaceIdResponseFromJson(response.body);
      if(placeDetail.status=='OK'){
        // print(placeDetail.result.formattedPhoneNumber);
        markers.forEach((element) {
          if(element.markerId.value==placeDetail.result.placeId){
            print('abc');
            print(placeDetail.result.name+"\n "+placeDetail.result.vicinity+"\n "+placeDetail.result.formattedPhoneNumber.toString());
        
            openDialog(placeDetail);
            

            // element.infoWindow = 
            // InfoWindow(
            //     title: placeDetail.result.name, snippet: placeDetail.result.vicinity);
          }
        });
      }
      // if(places == null || places.results.length == 0)
      //   return;



    } else {
      throw Exception('An error occurred getting places nearby');
    }
    // setState(() {
    //   searching = false; // 6
    // });
  }

  openDialog(placeDetail) {
     showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return LocationDialog(
            title: "Pharmacy", 
            content: placeDetail.result.name+"\n "+placeDetail.result.vicinity+"\n "+placeDetail.result.formattedPhoneNumber.toString(),
            onPressOk: () {
              FlutterClipboard.copy(placeDetail.result.name+", "+placeDetail.result.vicinity+", "+placeDetail.result.formattedPhoneNumber).then(( value ) => {
              showToast("Text copied."),
              Navigator.pop(context)}
            );
          }
          );
        },
      );
  }

}
