import 'dart:convert';

import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    id: 1,
    name: 'Doraemon',
    posterPath:
        'https://image.tmdb.org/t/p/w500/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg',
    backdropPath:
        'https://image.tmdb.org/t/p/w500/jyw8VKYEiM1UDzPB7NsisUgBeJ8.jpg',
    overview: 'Doraemon is a movie about a robot who is a hero to humans.',
    voteAverage: 8.5,
    voteCount: 1000,
    popularity: 8.5,
    firstAirDate: '2019-01-01',
    genreIds: [28, 12, 16, 35, 10751],
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'ドラえもん',
  );

  final tTvResnposeModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResnposeModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResnposeModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": "Doraemon",
            "poster_path":
                "https://image.tmdb.org/t/p/w500/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg",
            "backdrop_path":
                "https://image.tmdb.org/t/p/w500/jyw8VKYEiM1UDzPB7NsisUgBeJ8.jpg",
            "overview":
                "Doraemon is a movie about a robot who is a hero to humans.",
            "vote_average": 8.5,
            "vote_count": 1000,
            "popularity": 8.5,
            "first_air_date": "2019-01-01",
            "genre_ids": [28, 12, 16, 35, 10751],
            "origin_country": ["JP"],
            "original_language": "ja",
            "original_name": "ドラえもん"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
