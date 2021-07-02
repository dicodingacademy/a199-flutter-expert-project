import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailTable extends Equatable {
  final bool adult;
  final String? backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetailTable({
    required this.adult,
    required this.backdropPath,
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
        adult: movieDetail.adult,
        backdropPath: movieDetail.backdropPath,
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

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
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
