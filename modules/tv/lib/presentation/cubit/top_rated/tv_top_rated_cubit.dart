import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedState> {
  final GetTopRatedTvs getTopRatedTvs;

  TvTopRatedCubit({
    required this.getTopRatedTvs,
  }) : super(TvTopRatedState.initial());

  Future<void> fetchTopRatedTvs() async {
    emit(state.copyWith(state: RequestState.Loading));

    final result = await getTopRatedTvs.execute();

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
