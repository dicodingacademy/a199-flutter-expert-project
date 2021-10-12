import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  SeasonDetail({
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

  SeasonDetail.fromJson(Map<String, dynamic> json) {
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
