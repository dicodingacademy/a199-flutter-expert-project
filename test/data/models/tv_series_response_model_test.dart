import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/qmcoEOrTm6BcgR4iO7KBQKE9AKT.jpg",
    genreIds: [80, 18, 10759],
    id: 4614,
    originalName: 'NCIS',
    overview:
        "From murder and espionage to terrorism and stolen submarines, a team of special agents investigates any crime that has a shred of evidence connected to Navy and Marine Corps personnel, regardless of rank or position.",
    popularity: 4289.419,
    posterPath: "/2exOHePjOTquUsbThPGhuEjYTyA.jpg",
    firstAirDate: "2003-09-23",
    originCountry: ["US"],
    originalLanguage: "en",
    name: 'NCIS',
    voteAverage: 7.62,
    voteCount: 2094,
  );
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_air_tv_series.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/qmcoEOrTm6BcgR4iO7KBQKE9AKT.jpg",
            "genre_ids": [80, 18, 10759],
            "id": 4614,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "NCIS",
            "overview":
                "From murder and espionage to terrorism and stolen submarines, a team of special agents investigates any crime that has a shred of evidence connected to Navy and Marine Corps personnel, regardless of rank or position.",
            "popularity": 4289.419,
            "poster_path": "/2exOHePjOTquUsbThPGhuEjYTyA.jpg",
            "first_air_date": "2003-09-23",
            "name": "NCIS",
            "vote_average": 7.62,
            "vote_count": 2094
          },
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
