import 'package:equatable/equatable.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tvs.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

part 'tv_list_state.dart';

class TvListCubit extends Cubit<TvListState> {
  final GetNowPlayingTvs getNowPlayingTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  TvListCubit({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(TvListState.initial());

  void fetchNowPlayingTvs() async {
    emit(state.copyWith(
      nowPlayingState: RequestState.Loading,
    ));

    final result = await getNowPlayingTvs.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: tvsData,
        ));
      },
    );
  }

  void fetchPopularTvs() async {
    emit(state.copyWith(
      popularTvsState: RequestState.Loading,
    ));

    final result = await getPopularTvs.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          popularTvsState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          popularTvsState: RequestState.Loaded,
          popularTvs: tvsData,
        ));
      },
    );
  }

  void fetchTopRatedTvs() async {
    emit(state.copyWith(
      topRatedTvsState: RequestState.Loading,
    ));

    final result = await getTopRatedTvs.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedTvsState: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          topRatedTvsState: RequestState.Loaded,
          topRatedTvs: tvsData,
        ));
      },
    );
  }
}
