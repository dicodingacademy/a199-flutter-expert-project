import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetail', () {
    test('should be a equal to other MovieDetail', () async {
      final detail1 = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );

      expect(true, testMovieDetail == detail1);
    });

    test('should be a not equal because different adult', () async {
      final testDetail = MovieDetail(
        adult: true,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different backdropPath', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath_',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different list genders', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different id', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 2,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different originalTitle', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 2,
        originalTitle: 'originalTitles',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different overview', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitles',
        overview: 'overviewer',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different posterPath', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'poster_path',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different releaseDate', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'release_date',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different runtime', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 125,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different title', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title_1',
        voteAverage: 1,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different voteAverage', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 0,
        voteCount: 1,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a not equal because different voteCount', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 0,
      );
      expect(true, testMovieDetail != testDetail);
    });

    test('should be a equal to props', () async {
      final testDetail = MovieDetail(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        runtime: 120,
        title: 'title',
        voteAverage: 1,
        voteCount: 1,
      );

      final listValue = [
        false,
        'backdropPath',
        [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Comedy'),
          Genre(id: 3, name: 'Romance'),
        ],
        1,
        'originalTitle',
        'overview',
        'posterPath',
        'releaseDate',
        120,
        'title',
        1.0,
        1,
        ItemType.movie,
      ];

      expect(testDetail.props, listValue);
    });

    test('should be a true because category is Movie', () async {
      expect(testMovieDetail.category, ItemType.movie);
    });
  });
}
