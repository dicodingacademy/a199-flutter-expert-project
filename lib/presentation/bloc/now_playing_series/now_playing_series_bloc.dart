import 'dart:async';

import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_series_event.dart';

part 'now_playing_series_state.dart';

class NowPlayingSeriesBloc extends Bloc<NowPlayingSeriesEvent, NowPlayingSeriesState> {
  final GetNowPlayingSeries _getNowPlayingSeries;

  NowPlayingSeriesBloc(this._getNowPlayingSeries) : super(NowPlayingSeriesEmpty()) {
    on<OnNowPlayingSeries>(_onNowPlayingSeries);
  }

  FutureOr<void> _onNowPlayingSeries(
      OnNowPlayingSeries event, Emitter<NowPlayingSeriesState> emit) async {
    emit(NowPlayingSeriesLoading());

    final result = await _getNowPlayingSeries.execute();
    result.fold((failure) {
      emit(NowPlayingSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(NowPlayingSeriesEmpty())
          : emit(NowPlayingSeriesHasData(success));
    });
  }
}
