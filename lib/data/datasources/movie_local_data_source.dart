import 'package:ditonton/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(List movies);
  Future<List<MovieModel>> getCachedNowPlayingMovies();
}
