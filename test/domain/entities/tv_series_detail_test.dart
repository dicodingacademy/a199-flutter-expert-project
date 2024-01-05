import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('TvSeriesDetail', () {
    test('should be a equal to other TvSeriesDetail', () async {
      final detail1 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail == detail1);
    });

    test('should be a not equal because different adult', () async {
      final detail2 = TvSeriesDetail(
        adult: true,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

    test('should be a not equal because different backdropPath', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdrop_Path',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

        test('should be a not equal because different list genres', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action'), Genre(id: 2, name: 'Comedy')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

        test('should be a not equal because different id', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 2,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

        test('should be a not equal because different originalName', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'original Title',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

            test('should be a not equal because different overview', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overviewer',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

            test('should be a not equal because different posterPath', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPaths',
        episodeRunTime: null,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });


            test('should be a not equal because different episodeRunTime', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: 10,
        name: "title",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

                test('should be a not equal because different name', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "name",
        popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });


                test('should be a not equal because different popularity', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
        popularity: 3,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

                test('should be a not equal because different status', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
         popularity: 380.213,
        status: "",
        tagline: "",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });


                test('should be a not equal because different tagline', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
         popularity: 380.213,
        status: "Returning Series",
        tagline: "-",
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });


                test('should be a not equal because different voteAverage', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
         popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 10,
        voteCount: 1,
      );
      expect(true, testTvSeriesDetail != detail2);
    });


                test('should be a not equal because different voteCount', () async {
      final detail2 = TvSeriesDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [Genre(id: 1, name: 'Action')],
        id: 1,
        originalName: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        episodeRunTime: null,
        name: "title",
         popularity: 380.213,
        status: "Returning Series",
        tagline: "",
        voteAverage: 1,
        voteCount: 100,
      );
      expect(true, testTvSeriesDetail != detail2);
    });

    test('should be a true because category is TvSeries', () async {
      expect(testTvSeriesDetail.category, ItemType.tvSeries);
    });
  });
}
