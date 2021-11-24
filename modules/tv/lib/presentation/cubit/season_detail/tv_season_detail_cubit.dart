import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';

part 'tv_season_detail_state.dart';

class TvSeasonDetailCubit extends Cubit<TvSeasonDetailState> {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailCubit({
    required this.getTvSeasonDetail,
  }) : super(TvSeasonDetailState.initial());

  void fetchTvSeasonDetail(int id, int seasonNumber) async {
    emit(state.copyWith(state: RequestState.Loading));

    final detailResult = await getTvSeasonDetail.execute(id, seasonNumber);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (seasonDetail) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          seasonDetail: seasonDetail,
        ));
      },
    );
  }
}
