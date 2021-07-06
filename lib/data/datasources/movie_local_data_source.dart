import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_detail_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieDetailTable movie);
  Future<MovieDetailTable?> getMovieById(int id);
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

  @override
  Future<MovieDetailTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieDetailTable.fromMap(result);
    } else {
      return null;
    }
  }
}
