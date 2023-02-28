import 'package:equatable/equatable.dart';

class Series extends Equatable {
    Series({
      required this.backdropPath,
      required this.firstAirDate,
      required this.genreIds,
      required this.id,
      required this.name,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
    });

    Series.watchlist({
      required this.id,
      required this.overview,
      required this.posterPath,
      required this.name,
    });

    String? backdropPath;
    DateTime? firstAirDate;
    List<int>? genreIds;
    int id;
    String? name;
    List<String>? originCountry;
    String? originalLanguage;
    String? originalName;
    String? overview;
    double? popularity;
    String? posterPath;
    double? voteAverage;
    int? voteCount;

    @override
    List<Object?> get props => [
      backdropPath,
      firstAirDate,
      genreIds,
      id,
      name,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      voteAverage,
      voteCount,
    ];

}
