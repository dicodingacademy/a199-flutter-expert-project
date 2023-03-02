import 'dart:convert';

import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'originalTitle',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: '/path.jpg',
    voteAverage: 1,
    voteCount: 1,
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
            'backdropPath': '/path.jpg',
            'genreIds': [1, 2, 3],
            'id': 1,
            'name': 'originalTitle',
            'originCountry': ['originCountry'],
            'originalLanguage': 'originalLanguage',
            'originalName': 'originalName',
            'overview': 'overview',
            'popularity': 1,
            'posterPath': '/path.jpg',
            'voteAverage': 1,
            'voteCount': 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
