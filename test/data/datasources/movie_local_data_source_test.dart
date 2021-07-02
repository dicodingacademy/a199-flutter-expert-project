import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  test('should return success message when insert to database is success',
      () async {
    // arrange
    when(mockDatabaseHelper.insertWatchlist(testMovieDetailTable))
        .thenAnswer((_) async => 1);
    // act
    final result = await dataSource.insertWatchlist(testMovieDetailTable);
    // assert
    expect(result, 'Added to Watchlist');
  });

  test('should throw DatabaseException when insert to database is failed',
      () async {
    // arrange
    when(mockDatabaseHelper.insertWatchlist(testMovieDetailTable))
        .thenAnswer((_) async => 0);
    // act
    final call = dataSource.insertWatchlist(testMovieDetailTable);
    // assert
    expect(() => call, throwsA(isA<DatabaseException>()));
  });
}
