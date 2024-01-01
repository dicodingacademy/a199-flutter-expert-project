import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/provider/base_watchlist_notifier.dart';

class WatchlistMovieNotifier extends BaseWatchlistNotifier<Movie> {
  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    await fetchWatchlist(getWatchlistMovies.execute());
  }
}
