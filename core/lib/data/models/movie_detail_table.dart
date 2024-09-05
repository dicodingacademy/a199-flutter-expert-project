import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';

class MovieDetailTable extends Equatable {
  final int? adult;
  final int id;
  final String? originalTitle;
  final String overview;
  final String posterPath;
  final String? releaseDate;
  final int? runtime;
  final String title;
  final double? voteAverage;
  final int? voteCount;

  MovieDetailTable({
    required this.adult,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailTable.fromEntity(MovieDetail movieDetail) =>
      MovieDetailTable(
        adult: movieDetail.adult ? 1 : 0,
        id: movieDetail.id,
        originalTitle: movieDetail.originalTitle,
        overview: movieDetail.overview,
        posterPath: movieDetail.posterPath,
        releaseDate: movieDetail.releaseDate,
        runtime: movieDetail.runtime,
        title: movieDetail.title,
        voteAverage: movieDetail.voteAverage,
        voteCount: movieDetail.voteCount,
      );

  factory MovieDetailTable.fromMap(Map<String, dynamic> map) =>
      MovieDetailTable(
        adult: map['adult'],
        id: map['id'],
        originalTitle: map['originalTitle'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        releaseDate: map['releaseDate'],
        runtime: map['runtime'],
        title: map['title'],
        voteAverage: map['voteAverage'],
        voteCount: map['voteCount'],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "id": id,
        "originalTitle": originalTitle,
        "overview": overview,
        "posterPath": posterPath,
        "releaseDate": releaseDate,
        "runtime": runtime,
        "title": title,
        "voteAverage": voteAverage,
        "voteCount": voteCount,
      };

  @override
  List<Object?> get props => [
        adult,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
