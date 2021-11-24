part of 'movie_popular_cubit.dart';

class MoviePopularState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const MoviePopularState({
    required this.state,
    required this.movies,
    required this.message,
  });

  factory MoviePopularState.initial() {
    return const MoviePopularState(
      state: RequestState.Empty,
      movies: [],
      message: '',
    );
  }

  MoviePopularState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return MoviePopularState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, movies, message];
}
