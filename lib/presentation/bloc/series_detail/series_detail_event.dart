part of 'series_detail_bloc.dart';

abstract class SeriesDetailEvent extends Equatable {}

class OnSeriesDetail extends SeriesDetailEvent {
  final int id;

  OnSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}
