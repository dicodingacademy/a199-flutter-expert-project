import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
    airDate: DateTime.parse(json["air_date"]),
    episodeCount: json["episode_count"],
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate.toIso8601String(),
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber,
  };

  Season toEntity() {
    return Season(
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
    airDate,
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}
