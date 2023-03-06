import 'dart:async';

import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_series_recommendation.dart';

part 'series_recommendation_event.dart';

part 'series_recommendation_state.dart';

class SeriesRecommendationBloc
    extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetSeriesRecommendations _getRecommendationsSeries;

  SeriesRecommendationBloc(this._getRecommendationsSeries)
      : super(SeriesRecommendationEmpty()) {
    on<OnSeriesRecommendation>(_onSeriesRecommendation);
  }

  FutureOr<void> _onSeriesRecommendation(
      OnSeriesRecommendation event, Emitter<SeriesRecommendationState> emit) async {
    final id = event.id;

    emit(SeriesRecommendationLoading());
    final result = await _getRecommendationsSeries.execute(id);

    result.fold((failure) {
      emit(SeriesRecommendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(SeriesRecommendationEmpty())
          : emit(SeriesRecommendationHasData(success));
    });
  }
}
