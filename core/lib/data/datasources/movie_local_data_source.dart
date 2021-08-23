import '../../utils/exception.dart';
import 'db/database_helper.dart';
import '../models/movie_detail_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieDetailTable movie);
  Future<MovieDetailTable?> getMovieById(int id);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieDetailTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
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
