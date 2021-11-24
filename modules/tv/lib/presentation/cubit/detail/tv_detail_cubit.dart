import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/watchlist/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/watchlist/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/watchlist/save_tv_watchlist.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getWatchListStatus;
  final SaveTvWatchlist saveWatchlist;
  final RemoveTvWatchlist removeWatchlist;

  TvDetailCubit({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.initial());

  Future<void> fetchTvDetail(int id) async {
    emit(state.copyWith(tvState: RequestState.Loading));

    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          tvState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tv) {
        emit(state.copyWith(
          tvState: RequestState.Loaded,
          tv: tv,
        ));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              recommendationState: RequestState.Error,
              message: failure.message,
            ));
          },
          (tvs) {
            emit(state.copyWith(
              recommendationState: RequestState.Loaded,
              tvRecommendations: tvs,
            ));
          },
        );
      },
    );
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlist.execute(tv);

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

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlist.execute(tv);

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

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
