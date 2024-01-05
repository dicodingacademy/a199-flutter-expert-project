import 'package:ditonton/domain/entities/base_item_entity.dart';

// ignore: must_be_immutable
class Movie extends BaseItemEntity {
  static ItemType typeMovie = ItemType.movie;
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
          title: title ?? '',
          overview: overview ?? '',
          posterPath: posterPath ?? '',
          id: id,
          type: typeMovie,
        );

  Movie.watchlist({
    required this.id,
    this.overview,
    this.posterPath,
    this.title,
  }) : super(
            id: id,
            overview: overview ?? '',
            posterPath: posterPath ?? '',
            title: title ?? '',
            type: typeMovie);

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        this.type,
      ];
}
