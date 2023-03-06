import 'dart:async';

import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';

part 'series_detail_event.dart';

part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetSeriesDetail _getSeriesDetail;

  SeriesDetailBloc(this._getSeriesDetail) : super(SeriesDetailEmpty()) {
    on<OnSeriesDetail>(_onSeriesDetail);
  }

  FutureOr<void> _onSeriesDetail(
      OnSeriesDetail event, Emitter<SeriesDetailState> emit) async {
    final id = event.id;

    emit(SeriesDetailLoading());

    final result = await _getSeriesDetail.execute(id);

    result.fold((failure) {
      emit(SeriesDetailError(failure.message));
    }, (success) {
      emit(SeriesDetailHasData(success));
    });
  }
}
