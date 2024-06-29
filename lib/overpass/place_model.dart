import 'dart:convert';

import 'package:latlong2/latlong.dart';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  final String type;
  final int id;
  final LatLng position;
  final Tags tags;

  Place({
    required this.type,
    required this.id,
    required this.position,
    required this.tags,
  });

  static _getPosition(Map<String, dynamic> json) {
    final lat = json["lat"] ?? Center.fromJson(json["center"]).lat;
    final lon = json["lon"] ?? Center.fromJson(json["center"]).lon;
    return LatLng(lat, lon);
  }

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        type: json["type"],
        id: json["id"],
        position: _getPosition(json),
        tags: Tags.fromJson(json["tags"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "lat": position.latitude,
        "lon": position.longitude,
        "tags": tags.toJson(),
      };
}

class Tags {
  final String? name;
  final String? nameEn;
  final String tourism;

  Tags({
    this.name,
    this.nameEn,
    required this.tourism,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        name: json["name"],
        nameEn: json["name:en"],
        tourism: json["tourism"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "name:en": nameEn,
        "tourism": tourism,
      };
}

class Center {
  final double lat;
  final double lon;

  Center({
    required this.lat,
    required this.lon,
  });

  factory Center.fromJson(Map<String, dynamic> json) => Center(
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}
