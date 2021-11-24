import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/watchlist/get_watchlist_tvs.dart';

part 'tv_watchlist_state.dart';

class TvWatchlistCubit extends Cubit<TvWatchlistState> {
  final GetWatchlistTvs getWatchlistTvs;

  TvWatchlistCubit({
    required this.getWatchlistTvs,
  }) : super(TvWatchlistState.initial());

  Future<void> fetchWatchlistTvs() async {
    emit(state.copyWith(watchlistState: RequestState.Loading));

    final result = await getWatchlistTvs.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          watchlistState: RequestState.Loaded,
          watchlistTvs: tvsData,
        ));
      },
    );
  }
}
