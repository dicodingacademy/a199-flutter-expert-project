import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_state.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedCubit({
    required this.getTopRatedMovies,
  }) : super(MovieTopRatedState.initial());

  Future<void> fetchTopRatedMovies() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getTopRatedMovies.execute();

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
