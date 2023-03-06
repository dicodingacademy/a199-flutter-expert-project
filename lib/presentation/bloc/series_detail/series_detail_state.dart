part of 'series_detail_bloc.dart';

abstract class SeriesDetailState extends Equatable {}

class SeriesDetailEmpty extends SeriesDetailState {
  @override
  List<Object?> get props => [];
}

class SeriesDetailLoading extends SeriesDetailState {
  @override
  List<Object?> get props => [];
}

class SeriesDetailError extends SeriesDetailState {
  final String message;

  SeriesDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesDetail result;

  SeriesDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
