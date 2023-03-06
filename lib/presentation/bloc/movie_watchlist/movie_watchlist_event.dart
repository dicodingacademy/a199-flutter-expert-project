part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchListEvent extends Equatable {}

class OnFetchMovieWatchList extends MovieWatchListEvent {
  @override
  List<Object?> get props => [];
}

class MovieWatchListStatus extends MovieWatchListEvent {
  final int id;

  MovieWatchListStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class MovieWatchListAdd extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  MovieWatchListAdd(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieWatchListRemove extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  MovieWatchListRemove(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}
