// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/domain/entities/base_item_detail.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';

class TvSeriesDetail extends BaseItemDetail {
  final bool? adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String? name;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String posterPath;
  final String? status;
  final String? tagline;
  final double voteAverage;
  final int? voteCount;
  final int? episodeRunTime;

  TvSeriesDetail({
    this.adult,
    this.backdropPath,
    this.genres = const [],
    required this.id,
    this.name,
    this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.status,
    this.tagline,
    required this.voteAverage,
    this.voteCount,
    this.episodeRunTime,
  }) : super(
            title: name ?? '',
            overview: overview,
            posterPath: posterPath,
            id: id,
            genres: genres,
            runtime: episodeRunTime ?? 0,
            voteAverage: voteAverage,
            category: ItemType.tvSeries);

  @override
  List<Object> get props => [
        adult ?? false,
        backdropPath ?? '',
        genres,
        id,
        name ?? '',
        originalName ?? '',
        overview,
        popularity ?? '',
        posterPath,
        status ?? '',
        tagline ?? '',
        voteAverage,
        voteCount ?? 0,
        episodeRunTime ?? 0,
        this.category,
      ];
}
