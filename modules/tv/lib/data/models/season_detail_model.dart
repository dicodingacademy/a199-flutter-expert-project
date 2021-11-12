import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/domain/entities/season_detail.dart';

class SeasonDetailModel extends Equatable {
  SeasonDetailModel({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  late final String? airDate;
  late final List<EpisodeModel> episodes;
  late final String name;
  late final String overview;
  late final int id;
  late final String? posterPath;
  late final int seasonNumber;

  SeasonDetailModel.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodes = List.from(json['episodes'])
        .map((e) => EpisodeModel.fromJson(e))
        .toList();
    name = json['name'];
    overview = json['overview'];
    id = json['id'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['air_date'] = airDate;
    _data['episodes'] = episodes.map((e) => e.toJson()).toList();
    _data['name'] = name;
    _data['overview'] = overview;
    _data['id'] = id;
    _data['poster_path'] = posterPath;
    _data['season_number'] = seasonNumber;
    return _data;
  }

  SeasonDetail toEntity() {
    return SeasonDetail(
      airDate: airDate,
      episodes: episodes.map((e) => e.toEntity()).toList(),
      name: name,
      overview: overview,
      id: id,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        name,
        overview,
        id,
        posterPath,
        seasonNumber,
      ];
}
