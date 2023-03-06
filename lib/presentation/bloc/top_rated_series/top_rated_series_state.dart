part of 'top_rated_series_bloc.dart';

abstract class TopRatedSeriesState extends Equatable {}

class TopRatedSeriesEmpty extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesLoading extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesError extends TopRatedSeriesState {
  final String message;

  TopRatedSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedSeriesHasData extends TopRatedSeriesState {
  final List<Series> result;

  TopRatedSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
