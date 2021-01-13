// To parse this JSON data, do
//
//     final googlePlaceResponse = googlePlaceResponseFromJson(jsonString);

import 'dart:convert';

GooglePlaceResponse googlePlaceResponseFromJson(String str) => GooglePlaceResponse.fromJson(json.decode(str));

String googlePlaceResponseToJson(GooglePlaceResponse data) => json.encode(data.toJson());

class GooglePlaceResponse {
  GooglePlaceResponse({
    this.results,
  });

  List<Result> results;

  factory GooglePlaceResponse.fromJson(Map<String, dynamic> json) => GooglePlaceResponse(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.geometry,
    this.icon,
    this.name,
    this.vicinity,
    this.placeId,
  });

  Geometry geometry;
  String icon;
  String name;
  String vicinity;
  String placeId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    name: json["name"],
    placeId: json["place_id"],
    vicinity: json["vicinity"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "icon": icon,
    "name": name,
    "place_id": placeId,
    "vicinity": vicinity,
  };
}

class Geometry {
  Geometry({
    this.location,
  });

  Location location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
