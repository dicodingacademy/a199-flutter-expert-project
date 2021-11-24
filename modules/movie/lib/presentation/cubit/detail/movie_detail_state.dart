part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final RequestState movieState;
  final List<Movie> movieRecommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const MovieDetailState({
    required this.movie,
    required this.movieState,
    required this.movieRecommendations,
    required this.recommendationState,
    required this.message,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
  });

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movie: null,
      movieState: RequestState.Empty,
      movieRecommendations: [],
      recommendationState: RequestState.Empty,
      message: '',
      isAddedToWatchlist: false,
      watchlistMessage: '',
    );
  }

  MovieDetailState copyWith({
    MovieDetail? movie,
    RequestState? movieState,
    List<Movie>? movieRecommendations,
    RequestState? recommendationState,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      movieState: movieState ?? this.movieState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        movieState,
        movieRecommendations,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
