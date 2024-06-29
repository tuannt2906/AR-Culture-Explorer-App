import 'package:culture_explorer_ar/overpass/place_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Place> parsePlaces(http.Response response) {
  final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  final places = decodedResponse['elements'] as Iterable<dynamic>? ?? [];

  return places.map<Place>((json) => Place.fromJson(json)).toList();
}

Future<List<Place>> fetchPlaces(String bbox) async {
  try {
    const endpoint = 'https://overpass-api.de/api/interpreter';
    final query =
        '[out:json][timeout:25];(nwr["tourism"="museum"]($bbox); nwr["tourism"="gallery"]($bbox); );out center;';

    final response = await http.post(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: query);

    return compute(parsePlaces, response);
  } catch (error) {
    return [];
  }
}