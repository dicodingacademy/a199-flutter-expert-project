import 'dart:async';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendation_state.dart';

part 'movie_recommendation_event.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<OnMovieRecommendation>(_onMovieRecommendation);
  }

  FutureOr<void> _onMovieRecommendation(OnMovieRecommendation event,
      Emitter<MovieRecommendationState> emit) async {
    final id = event.id;
    emit(MovieRecommendationLoading());

    final result = await _getMovieRecommendations.execute(id);
    result.fold((failure) {
      emit(MovieRecommendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieRecommendationEmpty())
          : emit(MovieRecommendationHasData(success));
    });
  }
}
