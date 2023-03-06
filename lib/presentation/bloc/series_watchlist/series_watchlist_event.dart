part of 'series_watchlist_bloc.dart';

abstract class SeriesWatchListEvent extends Equatable {}

class OnFetchSeriesWatchList extends SeriesWatchListEvent {
  @override
  List<Object?> get props => [];
}

class SeriesWatchListStatus extends SeriesWatchListEvent {
  final int id;

  SeriesWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class SeriesWatchListAdd extends SeriesWatchListEvent {
  final SeriesDetail seriesDetail;

  SeriesWatchListAdd(this.seriesDetail);

  @override
  List<Object?> get props => [seriesDetail];
}

class SeriesWatchListRemove extends SeriesWatchListEvent {
  final SeriesDetail seriesDetail;

  SeriesWatchListRemove(this.seriesDetail);

  @override
  List<Object?> get props => [seriesDetail];
}
