import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

part 'tv_popular_state.dart';

class TvPopularCubit extends Cubit<TvPopularState> {
  final GetPopularTvs getPopularTvs;

  TvPopularCubit(this.getPopularTvs) : super(TvPopularState.initial());

  Future<void> fetchPopularTvs() async {
    emit(state.copyWith(
      state: RequestState.Loading,
    ));

    final result = await getPopularTvs.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.Error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          state: RequestState.Loaded,
          tvs: tvsData,
        ));
      },
    );
  }
}
