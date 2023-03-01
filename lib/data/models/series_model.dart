import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/series.dart';

class SeriesModel extends Equatable{
    SeriesModel({
      required this.backdropPath,
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

    final String? backdropPath;
    final List<int> genreIds;
    final int id;
    final String name;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String? posterPath;
    final double voteAverage;
    final int voteCount;

    factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      name: json["name"],
      originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
      "backdrop_path": backdropPath,
      "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
      "id": id,
      "name": name,
      "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
      "original_language": originalLanguage,
      "original_name": originalName,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };

    Series toEntity() {
      return Series(
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
    }

    @override
    List<Object?> get props => [
      backdropPath,
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
