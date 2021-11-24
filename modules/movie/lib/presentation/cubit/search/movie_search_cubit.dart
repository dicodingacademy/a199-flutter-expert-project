import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchCubit({
    required this.searchMovies,
  }) : super(MovieSearchState.initial());

  Future<void> fetchMovieSearch(String query) async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          searchResult: data,
        ));
      },
    );
  }
}
