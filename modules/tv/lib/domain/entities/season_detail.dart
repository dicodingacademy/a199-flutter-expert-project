import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/episode.dart';

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
  late final List<Episode> episodes;
  late final String name;
  late final String overview;
  late final int id;
  late final String? posterPath;
  late final int seasonNumber;

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
