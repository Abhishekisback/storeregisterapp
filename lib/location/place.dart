import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Place {
  double ?lat;
  double ?lng;

  Place({
    this.lat,
    this.lng,
  });

  @override
  String toString() {
    return 'Place(lat: $lat, long: $lng)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  //static final String androidKey = 'YAIzaSyBEsZWmxoZ89zOFRRoIAgRiowbsXLhU30I';
  //static final String iosKey = 'AIzaSyBEsZWmxoZ89zOFRRoIAgRiowbsXLhU30I';
  final apiKey =
      'AIzaSyATsJ5AVf-v6hq8HJ7fJ1f802wnP7EgW9M'; //Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result["predictions"]);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      //throw Exception(result['error_message']);
    } //else {
    throw Exception('Failed to fetch suggestion');
    //}
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result["result"]["geometry"]["location"]);
      if (result["status"] == "OK") {
        var data;
        final place = Place();
        data = Place();
        //final List type = c['types'];
        place.lat = result["result"]["geometry"]["location"]["lat"];
        place.lng = result["result"]["geometry"]["location"]["lng"];

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}