part of 'series_recommendation_bloc.dart';

abstract class SeriesRecommendationState extends Equatable {}

class SeriesRecommendationEmpty extends SeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class SeriesRecommendationLoading extends SeriesRecommendationState {
  @override
  List<Object?> get props => [];
}

class SeriesRecommendationError extends SeriesRecommendationState {
  final String message;

  SeriesRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeriesRecommendationHasData extends SeriesRecommendationState {
  final List<Series> result;

  SeriesRecommendationHasData(this.result);

  @override
  List<Object?> get props => [result];
}
