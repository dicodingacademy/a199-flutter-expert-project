import 'package:ditonton/common/mapper/mapper.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

class MovieDetailMapper extends Mapper<MovieDetailResponse, MovieDetail> {
  @override
  MovieDetail<Genre> map(MovieDetailResponse input) {
    return MovieDetail(
      adult: input.adult ?? false,
      backdropPath: input.backdropPath,
      budget: input.budget ?? 0,
      genres: input.genres ?? <Genre>[],
      homepage: input.homepage ?? '',
      id: input.id ?? 0,
      imdbId: input.imdbId,
      originalLanguage: input.originalLanguage ?? '',
      originalTitle: input.originalTitle ?? '',
      overview: input.overview ?? '',
      popularity: input.popularity ?? 0,
      posterPath: input.posterPath ?? '',
      releaseDate: input.releaseDate ?? '',
      revenue: input.revenue ?? 0,
      runtime: input.runtime ?? 0,
      status: input.status ?? '',
      tagline: input.tagline ?? '',
      title: input.title ?? '',
      video: input.video ?? false,
      voteAverage: input.voteAverage ?? 0,
      voteCount: input.voteCount ?? 0,
    );
  }
}
