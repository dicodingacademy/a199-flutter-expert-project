part of 'now_playing_series_bloc.dart';

abstract class NowPlayingSeriesState extends Equatable {}

class NowPlayingSeriesEmpty extends NowPlayingSeriesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingSeriesLoading extends NowPlayingSeriesState {
  @override
  List<Object?> get props => [];
}

class NowPlayingSeriesError extends NowPlayingSeriesState {
  final String message;

  NowPlayingSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingSeriesHasData extends NowPlayingSeriesState {
  final List<Series> result;

  NowPlayingSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
