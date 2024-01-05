import 'package:ditonton/domain/entities/base_item_entity.dart';


// ignore: must_be_immutable
class TvSeries extends BaseItemEntity {
  static ItemType typeTvSeries = ItemType.tvSeries;

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  TvSeries({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  }): super(
          title: name ?? '',
          overview: overview ?? '',
          posterPath: posterPath ?? '',
          id: id,
          type: typeTvSeries,
        );

  TvSeries.watchlist({
    required this.id,
    this.overview,
    this.posterPath,
    this.name,
  }) : super(
            id: id,
            overview: overview ?? '',
            posterPath: posterPath ?? '',
            title: name ?? '',
            type: typeTvSeries);

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      genreIds,
      id,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      firstAirDate,
      name,
      voteAverage,
      voteCount,
      this.type,
    ];
  }
}
