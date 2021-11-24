import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListCubit({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.initial());

  Future<void> fetchNowPlayingMovies() async {
    emit(state.copyWith(nowPlayingState: RequestState.Loading));

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: moviesData,
        ));
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(popularMoviesState: RequestState.Loading));

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          popularMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: moviesData,
        ));
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(topRatedMoviesState: RequestState.Loading));

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: moviesData,
        ));
      },
    );
  }
}
