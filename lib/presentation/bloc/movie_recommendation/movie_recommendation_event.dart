part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {}

class OnMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  OnMovieRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}
