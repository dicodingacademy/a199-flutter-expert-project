import 'package:ditonton/data/models/base_table.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

class MovieTable extends BaseTable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          overview: overview,
          category: Movie.typeMovie.toString(),
        );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );
}
