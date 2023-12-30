import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/provider/base_top_rated_notifier.dart';

class TopRatedMoviesNotifier extends BaseTopRatedNotifier<Movie> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({required this.getTopRatedMovies});

  Future<void> fetchTopRatedMovies() async {
    await fetchTopRatedMoviesOrTvSeries(
      result: getTopRatedMovies.execute(),
    );
  }
}
