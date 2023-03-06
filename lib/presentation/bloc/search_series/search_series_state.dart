
part of 'search_series_bloc.dart';

abstract class SearchSeriesState extends Equatable{}

class SearchSeriesInitial extends SearchSeriesState{
  @override
  List<Object?> get props => [];
}

class SearchSeriesLoading extends SearchSeriesState{
  @override
  List<Object?> get props => [];
}
class SearchSeriesEmpty extends SearchSeriesState{
  @override
  List<Object?> get props => [];
}
class SearchSeriesError extends SearchSeriesState{
  final String message;

  SearchSeriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class SearchSeriesHasData extends SearchSeriesState{
  final List<Series> result;

  SearchSeriesHasData(this.result);
  @override
  List<Object?> get props => [result];
}