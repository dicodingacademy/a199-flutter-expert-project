part of 'popular_series_bloc.dart';

abstract class PopularSeriesState extends Equatable {}

class PopularSeriesEmpty extends PopularSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularSeriesLoading extends PopularSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularSeriesError extends PopularSeriesState {
  final String message;

  PopularSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularSeriesHasData extends PopularSeriesState {
  final List<Series> result;

  PopularSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
