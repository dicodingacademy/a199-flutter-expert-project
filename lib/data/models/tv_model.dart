import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  late final String? posterPath;
  late final double popularity;
  late final int id;
  late final String? backdropPath;
  late final double voteAverage;
  late final String overview;
  late final String firstAirDate;
  late final List<String> originCountry;
  late final List<int> genreIds;
  late final String originalLanguage;
  late final int voteCount;
  late final String name;
  late final String originalName;

  TvModel.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    popularity = json['popularity'];
    id = json['id'];
    backdropPath = json['backdrop_path'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    firstAirDate = json['first_air_date'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    originalLanguage = json['original_language'];
    voteCount = json['vote_count'];
    name = json['name'];
    originalName = json['original_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['poster_path'] = posterPath;
    _data['popularity'] = popularity;
    _data['id'] = id;
    _data['backdrop_path'] = backdropPath;
    _data['vote_average'] = voteAverage;
    _data['overview'] = overview;
    _data['first_air_date'] = firstAirDate;
    _data['origin_country'] = originCountry;
    _data['genre_ids'] = genreIds;
    _data['original_language'] = originalLanguage;
    _data['vote_count'] = voteCount;
    _data['name'] = name;
    _data['original_name'] = originalName;

    return _data;
  }

  Tv toEntity() {
    return Tv(
      posterPath: posterPath,
      popularity: popularity,
      id: id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      firstAirDate: firstAirDate,
      originCountry: originCountry,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      voteCount: voteCount,
      name: name,
      originalName: originalName,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
