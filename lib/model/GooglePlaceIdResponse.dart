// To parse this JSON data, do
//
//     final googlePlaceIdResponse = googlePlaceIdResponseFromJson(jsonString);

import 'dart:convert';

GooglePlaceIdResponse googlePlaceIdResponseFromJson(String str) => GooglePlaceIdResponse.fromJson(json.decode(str));

String googlePlaceIdResponseToJson(GooglePlaceIdResponse data) => json.encode(data.toJson());

class GooglePlaceIdResponse {
  GooglePlaceIdResponse({
    this.result,
    this.status,
  });

  Result result;
  String status;

  factory GooglePlaceIdResponse.fromJson(Map<String, dynamic> json) => GooglePlaceIdResponse(
    result: Result.fromJson(json["result"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "status": status,
  };
}

class Result {
  Result({
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.internationalPhoneNumber,
    this.name,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  String formattedAddress;
  String formattedPhoneNumber;
  Geometry geometry;
  String icon;
  String internationalPhoneNumber;
  String name;
  String placeId;
  String reference;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    formattedAddress: json["formatted_address"],
    formattedPhoneNumber: json["formatted_phone_number"],
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    internationalPhoneNumber: json["international_phone_number"],
    name: json["name"],
    placeId: json["place_id"],
    reference: json["reference"],
    types: List<String>.from(json["types"].map((x) => x)),
    url: json["url"],
    userRatingsTotal: json["user_ratings_total"],
    utcOffset: json["utc_offset"],
    vicinity: json["vicinity"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "formatted_address": formattedAddress,
    "formatted_phone_number": formattedPhoneNumber,
    "geometry": geometry.toJson(),
    "icon": icon,
    "international_phone_number": internationalPhoneNumber,
    "name": name,
    "place_id": placeId,
    "reference": reference,
    "types": List<dynamic>.from(types.map((x) => x)),
    "url": url,
    "user_ratings_total": userRatingsTotal,
    "utc_offset": utcOffset,
    "vicinity": vicinity,
    "website": website,
  };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "viewport": viewport.toJson(),
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

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast.toJson(),
    "southwest": southwest.toJson(),
  };
}
