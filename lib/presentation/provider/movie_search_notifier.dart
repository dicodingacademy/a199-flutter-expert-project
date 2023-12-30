import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/provider/base_search_notifier.dart';

class MovieSearchNotifier extends BaseSearchNotifier<Movie> {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  Future<void> fetchMovieSearch(String query) async {
    await fetchMovieOrTvSeriesSearch(
      searchMovies.execute(query),
    );
  }
}
