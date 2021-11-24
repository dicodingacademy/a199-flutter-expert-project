import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'movie_popular_state.dart';

class MoviePopularCubit extends Cubit<MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularCubit(this.getPopularMovies) : super(MoviePopularState.initial());

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          movies: moviesData,
        ));
      },
    );
  }
}
