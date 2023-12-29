// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  const TvSeriesModel(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      required this.id,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.name,
      this.voteAverage,
      this.voteCount});

  Map<String, Object?> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'name': name,
      'vote_average': voteAverage,
      'vote_count': voteCount
    };
  }

  static TvSeriesModel fromJson(Map<String, Object?> json) {
    return TvSeriesModel(
        adult: json['adult'] == null ? null : json['adult'] as bool,
        backdropPath: json['backdrop_path'] == null
            ? null
            : json['backdrop_path'] as String,
        genreIds:
            json['genre_ids'] == null ? null : (json['genre_ids'] as List).map((e) => e as int).toList(),
        id: json['id'] as int,
        originCountry: json['origin_country'] == null
            ? null
            : (json['origin_country'] as List).map((e) => e as String).toList(),
        originalLanguage: json['original_language'] == null
            ? null
            : json['original_language'] as String,
        originalName: json['original_name'] == null
            ? null
            : json['original_name'] as String,
        overview: json['overview'] == null ? null : json['overview'] as String,
        popularity:
            json['popularity'] == null ? null : json['popularity'] as double,
        posterPath:
            json['poster_path'] == null ? null : json['poster_path'] as String,
        firstAirDate: json['first_air_date'] == null
            ? null
            : json['first_air_date'] as String,
        name: json['name'] == null ? null : json['name'] as String,
        voteAverage: json['vote_average'] == null
            ? null
            : json['vote_average'] as double,
        voteCount:
            json['vote_count'] == null ? null : json['vote_count'] as int);
  }

  TvSeries toEntity() {
    return TvSeries(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
    ];
  }
}
