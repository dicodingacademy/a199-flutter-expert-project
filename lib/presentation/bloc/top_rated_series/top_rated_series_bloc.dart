import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';

part 'top_rated_series_state.dart';

class TopRatedSeriesBloc extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries _getTopRatedSeries;

  TopRatedSeriesBloc(this._getTopRatedSeries) : super(TopRatedSeriesEmpty()) {
    on<OnTopRatedSeries>(_onTopRatedSeries);
  }

  FutureOr<void> _onTopRatedSeries(
      OnTopRatedSeries event, Emitter<TopRatedSeriesState> emit) async {
    emit(TopRatedSeriesLoading());
    final result = await _getTopRatedSeries.execute();

    result.fold((failure) {
      emit(TopRatedSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TopRatedSeriesEmpty())
          : emit(TopRatedSeriesHasData(success));
    });
  }
}
