import 'package:ditonton/domain/entities/base_item_detail.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';

class MovieDetail extends BaseItemDetail {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          title: title,
          overview: overview,
          posterPath: posterPath,
          id: id,
          genres: genres,
          runtime: runtime,
          voteAverage: voteAverage,
          category: ItemType.movie
        );

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object> get props => [
        adult,
        backdropPath ?? '',
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
        this.category,
      ];
}
