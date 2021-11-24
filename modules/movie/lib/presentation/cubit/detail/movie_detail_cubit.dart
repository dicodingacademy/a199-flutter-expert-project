import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/watchlist/get_movie_watchlist_status.dart';
import 'package:movie/domain/usecases/watchlist/remove_movie_watchlist.dart';
import 'package:movie/domain/usecases/watchlist/save_movie_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getMovieWatchListStatus,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
  }) : super(MovieDetailState.initial());

  Future<void> fetchMovieDetail(int id) async {
    emit(state.copyWith(movieState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          movieState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movie) {
        emit(state.copyWith(
          movieState: RequestState.Loaded,
          movie: movie,
        ));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              recommendationState: RequestState.Error,
              message: failure.message,
            ));
          },
          (movies) {
            emit(state.copyWith(
              recommendationState: RequestState.Loaded,
              movieRecommendations: movies,
            ));
          },
        );
      },
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    emit(state.copyWith(watchlistMessage: ''));

    final result = await saveMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
        ));
      },
      (successMessage) async {
        emit(state.copyWith(
          watchlistMessage: successMessage,
        ));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    emit(state.copyWith(watchlistMessage: ''));

    final result = await removeMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          watchlistMessage: failure.message,
        ));
      },
      (successMessage) async {
        emit(state.copyWith(
          watchlistMessage: successMessage,
        ));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getMovieWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
