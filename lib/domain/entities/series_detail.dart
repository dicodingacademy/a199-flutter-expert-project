import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';

class SeriesDetail extends Equatable {
    SeriesDetail({
      required this.adult,
      required this.backdropPath,
      required this.genres,
      required this.id,
      required this.name,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.seasons,
      required this.voteAverage,
      required this.voteCount,
    });

    final bool adult;
    final String backdropPath;
    final List<Genre> genres;
    final int id;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final List<Season> seasons;
    final double voteAverage;
    final int voteCount;

    @override
    List<Object?> get props => [
      adult,
      backdropPath,
      genres,
      id,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalName,
      overview,
      popularity,
      posterPath,
      seasons,
      voteAverage,
      voteCount,
    ];
}