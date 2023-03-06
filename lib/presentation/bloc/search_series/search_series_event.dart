
part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent extends Equatable{}

class OnQueryTvChange extends SearchSeriesEvent{
  final String query;

  OnQueryTvChange(this.query);
  @override
  List<Object?> get props => [query];

}