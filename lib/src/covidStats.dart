import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'covidStats.g.dart';

@JsonSerializable()
class Latest {
  Latest({this.confirmed, this.deaths, this.recovered});

  factory Latest.fromJson(Map<String, dynamic> json) => _$LatestFromJson(json);
  Map<String, dynamic> toJson() => _$LatestToJson(this);

  final int confirmed;
  final int deaths;
  final int recovered;
}

@JsonSerializable()
class Coordinates {
  Coordinates({this.latitude, this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  final String latitude;
  final String longitude;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Location {
  Location({
    this.coordinates,
    this.country,
    this.countryCode,
    this.id,
    this.lastUpdated,
    this.latest,
    this.province,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final Coordinates coordinates;
  final String country;
  final String countryCode;
  final int id;
  final String lastUpdated;
  final Latest latest;
  final String province;
}

@JsonSerializable()
class CovidStats {
  CovidStats({
    this.latest,
    this.locations,
  });

  factory CovidStats.fromJson(Map<String, dynamic> json) =>
      _$CovidStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CovidStatsToJson(this);

  final Latest latest;
  final List<Location> locations;
}

Future<CovidStats> getCovidStats() async {
  const covidStatsURL =
      'https://coronavirus-tracker-api.herokuapp.com/v2/locations';

  // Retrieve the latest stats
  final response = await http.get(covidStatsURL);
  if (response.statusCode == 200) {
    return CovidStats.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(covidStatsURL));
  }
}
