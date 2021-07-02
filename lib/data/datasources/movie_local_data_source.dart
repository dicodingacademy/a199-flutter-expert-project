import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_detail_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieDetailTable movie);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieDetailTable movie) async {
    final result = await databaseHelper.insertWatchlist(movie);
    if (result > 0) {
      return 'Added to Watchlist';
    } else {
      throw DatabaseException();
    }
  }
}
