import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tvSeries = TvSeries(
    adult: false,
    backdropPath: "/7v3bO3pNnyLHLlwETtmyQxKV2Ba.jpg",
    genreIds: [35, 10766, 18],
    id: 73362,
    name: "The Ladies' Paradise",
    overview:
        "Follow Teresa Iorio, a young woman who leaves her rural Sicilian hometown for Milan to find work--and much more--at a newly opened department store: The Ladies' Paradise.",
    popularity: 380.213,
    posterPath: '/7k0D1feQhS59O2k8xkf5UR19LUi.jpg',
    firstAirDate: "2015-12-08",
    originCountry: ["IT"],
    originalLanguage: "it",
    originalName: "Il paradiso delle signore",
    voteAverage: 7.625,
    voteCount: 12,
  );

  final tvSeries2 = TvSeries(
    adult: false,
    backdropPath: "/7v3bO3pNnyLHLlwETtmyQxKV2Ba.jpg",
    genreIds: [35, 10766, 18],
    id: 73362,
    name: "The Ladies' Paradise",
    overview:
        "Follow Teresa Iorio, a young woman who leaves her rural Sicilian hometown for Milan to find work--and much more--at a newly opened department store: The Ladies' Paradise.",
    popularity: 380.213,
    posterPath: '/7k0D1feQhS59O2k8xkf5UR19LUi.jpg',
    firstAirDate: "2015-12-08",
    originCountry: ["IT"],
    originalLanguage: "it",
    originalName: "Il paradiso delle signore",
    voteAverage: 8.625,
    voteCount: 12,
  );

  final tvSeriesWatchlist = TvSeries(
    adult: null,
    backdropPath: null,
    genreIds: null,
    id: 1,
    originalName: null,
    overview: 'overview',
    popularity: null,
    posterPath: 'posterPath',
    firstAirDate: null,
    name: 'title',
    originCountry: null,
    originalLanguage: null,
    voteAverage: null,
    voteCount: null,
  );

  final tvSeriesWatchlist2 = TvSeries(
    adult: null,
    backdropPath: null,
    genreIds: null,
    id: 1,
    originalName: null,
    overview: 'overview',
    popularity: null,
    posterPath: 'posterPath',
    firstAirDate: null,
    name: 'title',
    originCountry: null,
    originalLanguage: null,
    voteAverage: null,
    voteCount: 0,
  );

  group('Tv Series', () {
    test('should be a equal to other Tv Series', () async {
      expect(true, testTvSeries == tvSeries);
    });

    test('should be a not equal because voteAverage different', () async {
      expect(true, testTvSeries != tvSeries2);
    });

    test('should be a true because category is Tv Series', () async {
      expect(testTvSeries.type, ItemType.tvSeries);
    });
  });

  group('TvSeries.watchlist', () {
    test('should be a equal to other Tv Series', () async {
      expect(true, testWatchlistTvSeries == tvSeriesWatchlist);
    });

    test('should be a not equal because adult true', () async {
      expect(true, testWatchlistTvSeries != tvSeriesWatchlist2);
    });

    test('should be a true because category is Tv Series', () async {
      expect(testTvSeries.type, ItemType.tvSeries);
    });
  });
}
