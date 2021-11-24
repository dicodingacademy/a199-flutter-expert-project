part of 'movie_top_rated_cubit.dart';

class MovieTopRatedState extends Equatable {
  final RequestState state;
  final List<Movie> movies;
  final String message;

  const MovieTopRatedState({
    required this.state,
    required this.movies,
    required this.message,
  });

  factory MovieTopRatedState.initial() {
    return const MovieTopRatedState(
      state: RequestState.Empty,
      movies: [],
      message: '',
    );
  }

  MovieTopRatedState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return MovieTopRatedState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [state, movies, message];
}
