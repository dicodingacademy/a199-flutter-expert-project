import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/watchlist/get_watchlist_movies.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistCubit extends Cubit<MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistCubit({
    required this.getWatchlistMovies,
  }) : super(MovieWatchlistState.initial());

  Future<void> fetchWatchlistMovies() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (moviesData) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistMovies: moviesData,
        ));
      },
    );
  }
}
