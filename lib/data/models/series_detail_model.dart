import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

class SeriesDetailResponse extends Equatable {
  SeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<SeasonModel> seasons;
  final double voteAverage;
  final int voteCount;

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) => SeriesDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    id: json["id"],
    name: json["name"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "id": id,
    "name": name,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  SeriesDetail toEntity() {
    return SeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((e) => e.toEntity()).toList(),
      id: id,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      seasons: seasons.map((e) => e.toEntity()).toList(),
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    originalName,
    overview,
    popularity,
    posterPath,
    seasons,
    voteAverage,
    voteCount,
  ];

}