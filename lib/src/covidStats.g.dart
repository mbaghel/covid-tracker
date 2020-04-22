// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covidStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Latest _$LatestFromJson(Map<String, dynamic> json) {
  return Latest(
      confirmed: json['confirmed'] as int,
      deaths: json['deaths'] as int,
      recovered: json['recovered'] as int);
}

Map<String, dynamic> _$LatestToJson(Latest instance) => <String, dynamic>{
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'recovered': instance.recovered
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return Coordinates(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String);
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      country: json['country'] as String,
      countryCode: json['country_code'] as String,
      id: json['id'] as int,
      lastUpdated: json['last_updated'] as String,
      latest: json['latest'] == null
          ? null
          : Latest.fromJson(json['latest'] as Map<String, dynamic>),
      province: json['province'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'country': instance.country,
      'country_code': instance.countryCode,
      'id': instance.id,
      'last_updated': instance.lastUpdated,
      'latest': instance.latest,
      'province': instance.province
    };

CovidStats _$CovidStatsFromJson(Map<String, dynamic> json) {
  return CovidStats(
      latest: json['latest'] == null
          ? null
          : Latest.fromJson(json['latest'] as Map<String, dynamic>),
      locations: (json['locations'] as List)
          ?.map((e) =>
              e == null ? null : Location.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CovidStatsToJson(CovidStats instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'locations': instance.locations
    };
