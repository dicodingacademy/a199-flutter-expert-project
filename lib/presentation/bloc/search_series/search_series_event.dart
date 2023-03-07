
part of 'search_series_bloc.dart';

abstract class SearchSeriesEvent extends Equatable{}

class OnQuerySeriesChange extends SearchSeriesEvent{
  final String query;

  OnQuerySeriesChange(this.query);
  @override
  List<Object?> get props => [query];

}