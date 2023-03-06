import 'dart:async';

import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_watchlist_event.dart';

part 'series_watchlist_state.dart';

class SeriesWatchListBloc extends Bloc<SeriesWatchListEvent, SeriesWatchListState> {
  final GetWatchlistSeries _getWatchlistSeries;
  final GetWatchListStatusSeries _getWatchlistStatusSeries;
  final RemoveWatchlistSeries _removeWatchlistSeries;
  final SaveWatchlistSeries _saveWatchlistSeries;

  SeriesWatchListBloc(this._getWatchlistSeries, this._getWatchlistStatusSeries,
      this._removeWatchlistSeries, this._saveWatchlistSeries)
      : super(SeriesWatchListInitial()) {
    on<OnFetchSeriesWatchList>(_onFetchSeriesWatchList);
    on<SeriesWatchListStatus>(_onSeriesWatchListStatus);
    on<SeriesWatchListAdd>(_onSeriesWatchListAdd);
    on<SeriesWatchListRemove>(_onSeriesWatchListRemove);
  }

  FutureOr<void> _onFetchSeriesWatchList(
      OnFetchSeriesWatchList event, Emitter<SeriesWatchListState> emit) async {
    emit(SeriesWatchListLoading());
    final result = await _getWatchlistSeries.execute();
    result.fold((failure) {
      emit(SeriesWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(SeriesWatchListEmpty())
          : emit(SeriesWatchListHasData(success));
    });
  }

  FutureOr<void> _onSeriesWatchListStatus(
      SeriesWatchListStatus event, Emitter<SeriesWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchlistStatusSeries.execute(id);
    emit(SeriesWatchListIsAdded(result));
  }

  FutureOr<void> _onSeriesWatchListAdd(
      SeriesWatchListAdd event, Emitter<SeriesWatchListState> emit) async {
    final series = event.seriesDetail;
    final result = await _saveWatchlistSeries.execute(series);
    result.fold((failure) {
      emit(SeriesWatchListError(failure.message));
    }, (success) {
      emit(SeriesWatchListMessage(success));
    });
  }

  FutureOr<void> _onSeriesWatchListRemove(
      SeriesWatchListRemove event, Emitter<SeriesWatchListState> emit) async {
    final series = event.seriesDetail;
    final result = await _removeWatchlistSeries.execute(series);

    result.fold((failure) {
      emit(SeriesWatchListError(failure.message));
    }, (success) {
      emit(SeriesWatchListMessage(success));
    });
  }
}
