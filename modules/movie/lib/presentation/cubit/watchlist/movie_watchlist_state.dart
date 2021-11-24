part of 'movie_watchlist_cubit.dart';

class MovieWatchlistState extends Equatable {
  final RequestState watchlistState;
  final List<Movie> watchlistMovies;
  final String message;

  const MovieWatchlistState({
    required this.watchlistState,
    required this.watchlistMovies,
    required this.message,
  });

  factory MovieWatchlistState.initial() {
    return const MovieWatchlistState(
      watchlistState: RequestState.Empty,
      watchlistMovies: [],
      message: '',
    );
  }

  MovieWatchlistState copyWith({
    RequestState? watchlistState,
    List<Movie>? watchlistMovies,
    String? message,
  }) {
    return MovieWatchlistState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [watchlistState, watchlistMovies, message];
}
