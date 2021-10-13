import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  late final String? airDate;
  late final int episodeNumber;
  late final int id;
  late final String name;
  late final String overview;
  late final String productionCode;
  late final int seasonNumber;
  late final String? stillPath;
  late final double? voteAverage;
  late final int voteCount;

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
