import 'dart:async';

import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/search_series.dart';

part 'search_series_event.dart';

part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries _searchSeries;

  SearchSeriesBloc(this._searchSeries) : super(SearchSeriesInitial()) {
    on<OnQuerySeriesChange>(_onQueryTvChange);
  }

  FutureOr<void> _onQueryTvChange(OnQuerySeriesChange event, Emitter<SearchSeriesState> emit) async {
    final query = event.query;
    emit(SearchSeriesEmpty());
    final result = await _searchSeries.execute(query);

    result.fold((failure) {
      emit(SearchSeriesError(failure.message));
    }, (success) {
      success.isEmpty ? emit(SearchSeriesEmpty()) : emit(SearchSeriesHasData(success));
    });
  }
}
