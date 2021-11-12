import 'package:equatable/equatable.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  // move or tv
  final String? type;

  WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.type = "movie",
  });

  // TODO: think a way about this
  // factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
  //       id: movie.id,
  //       title: movie.title,
  //       posterPath: movie.posterPath,
  //       overview: movie.overview,
  //       type: 'movie',
  //     );

  // factory WatchlistTable.fromTvEntity(TvDetail tv) => WatchlistTable(
  //       id: tv.id,
  //       title: tv.name,
  //       posterPath: tv.posterPath,
  //       overview: tv.overview,
  //       type: 'tv',
  //     );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  // Movie toMovieEntity() => Movie.watchlist(
  //       id: id,
  //       overview: overview,
  //       posterPath: posterPath,
  //       title: title,
  //     );

  // Tv toTvEntity() => Tv.watchlist(
  //       id: id,
  //       overview: overview,
  //       posterPath: posterPath,
  //       name: title,
  //     );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
