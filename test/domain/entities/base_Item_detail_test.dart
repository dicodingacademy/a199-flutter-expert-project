import 'package:ditonton/domain/entities/base_item_detail.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

class TestItemDetial extends BaseItemDetail {
  TestItemDetial({
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.id,
    required super.genres,
    required super.runtime,
    required super.voteAverage,
    required super.category,
  });
}

void main() {
  final currentItem = TestItemDetial(
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    id: 1,
    genres: [Genre(id: 1, name: 'Action')],
    runtime: 20,
    voteAverage: 1,
    category: ItemType.movie,
  );

  group('BaseItemDetail', () {
    test('should be a equal to other BaseItemDetail', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem == testItem);
    });

    test('should be a not equal because title different', () async {
      final testItem = TestItemDetial(
        title: 'title 2',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });


    test('should be a not equal because overview different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overviewers',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });


    test('should be a not equal because posterPath different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'poster-Path',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });


    test('should be a not equal because id different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 2,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });

    test('should be a not equal because genres different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action'), Genre(id: 2, name: 'Comedy')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });

    test('should be a not equal because runtime different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 2,
        voteAverage: 1,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });


    test('should be a not equal because voteAverage different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 10,
        category: ItemType.movie,
      );

      expect(true, currentItem != testItem);
    });

    test('should be a not equal because category different', () async {
      final testItem = TestItemDetial(
        title: 'title',
        overview: 'overview',
        posterPath: 'posterPath',
        id: 1,
        genres: [Genre(id: 1, name: 'Action')],
        runtime: 20,
        voteAverage: 1,
        category: ItemType.tvSeries,
      );

      expect(true, currentItem != testItem);
    });
  });
}
