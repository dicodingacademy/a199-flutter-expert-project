part of "movie_detail_bloc.dart";

abstract class MovieDetailEvent extends Equatable {}

class OnMovieDetail extends MovieDetailEvent {
  final int id;

  OnMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}
