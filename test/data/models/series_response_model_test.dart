import 'dart:convert';

import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: "/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg",
    genreIds: [18, 10759],
    id: 100088,
    name: "The Last of Us",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The Last of Us",
    overview: "Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.",
    popularity: 4703.161,
    posterPath: "/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg",
    voteAverage: 8.8,
    voteCount: 2179,
  );
  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_series.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg",
            "genre_ids": [
                18,
                10759
            ],
            "id": 100088,
            "name": "The Last of Us",
            "origin_country": [
                "US"
            ],
            "original_language": "en",
            "original_name": "The Last of Us",
            "overview": "Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.",
            "popularity": 4703.161,
            "poster_path": "/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg",
            "vote_average": 8.8,
            "vote_count": 2179
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
