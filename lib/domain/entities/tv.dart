import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
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
