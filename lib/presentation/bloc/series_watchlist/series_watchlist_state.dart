part of 'series_watchlist_bloc.dart';

abstract class SeriesWatchListState extends Equatable {}

class SeriesWatchListInitial extends SeriesWatchListState {
  @override
  List<Object?> get props => [];
}

class SeriesWatchListEmpty extends SeriesWatchListState {
  @override
  List<Object?> get props => [];
}

class SeriesWatchListLoading extends SeriesWatchListState {
  @override
  List<Object?> get props => [];
}

class SeriesWatchListError extends SeriesWatchListState {
  final String message;

  SeriesWatchListError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeriesWatchListHasData extends SeriesWatchListState {
  final List<Series> result;

  SeriesWatchListHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class SeriesWatchListIsAdded extends SeriesWatchListState {
  final bool isAdded;

  SeriesWatchListIsAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class SeriesWatchListMessage extends SeriesWatchListState {
  final String message;

  SeriesWatchListMessage(this.message);

  @override
  List<Object?> get props => [message];
}
