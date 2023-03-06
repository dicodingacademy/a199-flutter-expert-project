part of 'series_recommendation_bloc.dart';

abstract class SeriesRecommendationEvent extends Equatable {}

class OnSeriesRecommendation extends SeriesRecommendationEvent {
  final int id;

  OnSeriesRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}
