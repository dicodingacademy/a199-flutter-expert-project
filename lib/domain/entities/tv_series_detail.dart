// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/domain/entities/base_item_detail.dart';
import 'package:ditonton/domain/entities/genre.dart';

class TvSeriesDetail extends BaseItemDetail {
  final bool? adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String? name;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String posterPath;
  final String? status;
  final String? tagline;
  final double voteAverage;
  final int? voteCount;
  final int? episodeRunTime;

  TvSeriesDetail({
    this.adult,
    this.backdropPath,
    this.genres = const [],
    required this.id,
    this.name,
    this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.status,
    this.tagline,
    required this.voteAverage,
    this.voteCount,
    this.episodeRunTime,
  }) : super(
          title: name ?? '',
          overview: overview,
          posterPath: posterPath,
          id: id,
          genres: genres,
          runtime: episodeRunTime ?? 0,
          voteAverage: voteAverage,
        );

  TvSeriesDetail copyWith({
    bool? adult,
    String? backdropPath,
    List<Genre>? genres,
    int? id,
    String? name,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    int? runtime,
    String? status,
    String? tagline,
    double? voteAverage,
    int? voteCount,
    int? episodeRunTime,
  }) {
    return TvSeriesDetail(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genres: genres ?? this.genres,
      id: id ?? this.id,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
    );
  }
}

class SpokenLanguages {
  final String? englishName;
  final String? iso6391;
  final String? name;
  const SpokenLanguages({this.englishName, this.iso6391, this.name});
  SpokenLanguages copyWith(
      {String? englishName, String? iso6391, String? name}) {
    return SpokenLanguages(
        englishName: englishName ?? this.englishName,
        iso6391: iso6391 ?? this.iso6391,
        name: name ?? this.name);
  }
}

class ProductionCountries {
  final String? iso31661;
  final String? name;
  const ProductionCountries({this.iso31661, this.name});
  ProductionCountries copyWith({String? iso31661, String? name}) {
    return ProductionCountries(
        iso31661: iso31661 ?? this.iso31661, name: name ?? this.name);
  }
}

class ProductionCompanies {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;
  const ProductionCompanies(
      {this.id, this.logoPath, this.name, this.originCountry});
  ProductionCompanies copyWith(
      {int? id, String? logoPath, String? name, String? originCountry}) {
    return ProductionCompanies(
        id: id ?? this.id,
        logoPath: logoPath ?? this.logoPath,
        name: name ?? this.name,
        originCountry: originCountry ?? this.originCountry);
  }
}

class BelongsToCollection {
  final int? id;
  final String? name;
  final String? posterPath;
  final dynamic backdropPath;
  const BelongsToCollection(
      {this.id, this.name, this.posterPath, this.backdropPath});
  BelongsToCollection copyWith(
      {int? id, String? name, String? posterPath, dynamic backdropPath}) {
    return BelongsToCollection(
        id: id ?? this.id,
        name: name ?? this.name,
        posterPath: posterPath ?? this.posterPath,
        backdropPath: backdropPath ?? this.backdropPath);
  }
}
