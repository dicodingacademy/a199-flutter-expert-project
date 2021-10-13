import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  TvDetailModel({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.seasons,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  late final String? backdropPath;
  late final List<int> episodeRunTime;
  late final String? firstAirDate;
  late final List<GenreModel> genres;
  late final List<SeasonModel> seasons;
  late final String homepage;
  late final int id;
  late final bool inProduction;
  late final List<String> languages;
  late final String? lastAirDate;
  late final String name;
  late final int numberOfEpisodes;
  late final int numberOfSeasons;
  late final List<String> originCountry;
  late final String originalLanguage;
  late final String originalName;
  late final String overview;
  late final double popularity;
  late final String? posterPath;
  late final String status;
  late final String tagline;
  late final String type;
  late final double voteAverage;
  late final int voteCount;

  TvDetailModel.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    episodeRunTime = List.castFrom<dynamic, int>(json['episode_run_time']);
    firstAirDate = json['first_air_date'];
    genres =
        List.from(json['genres']).map((e) => GenreModel.fromJson(e)).toList();
    seasons =
        List.from(json['seasons']).map((e) => SeasonModel.fromJson(e)).toList();
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = List.castFrom<dynamic, String>(json['languages']);
    lastAirDate = json['last_air_date'];
    name = json['name'];
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['backdrop_path'] = backdropPath;
    _data['episode_run_time'] = episodeRunTime;
    _data['first_air_date'] = firstAirDate;
    _data['genres'] = genres.map((e) => e.toJson()).toList();
    _data['seasons'] = seasons.map((e) => e.toJson()).toList();
    _data['homepage'] = homepage;
    _data['id'] = id;
    _data['in_production'] = inProduction;
    _data['languages'] = languages;
    _data['last_air_date'] = lastAirDate;
    _data['name'] = name;
    _data['number_of_episodes'] = numberOfEpisodes;
    _data['number_of_seasons'] = numberOfSeasons;
    _data['origin_country'] = originCountry;
    _data['original_language'] = originalLanguage;
    _data['original_name'] = originalName;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['status'] = status;
    _data['tagline'] = tagline;
    _data['type'] = type;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;

    return _data;
  }

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: backdropPath,
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genres.map((e) => e.toEntity()).toList(),
      seasons: seasons.map((e) => e.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        seasons,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
