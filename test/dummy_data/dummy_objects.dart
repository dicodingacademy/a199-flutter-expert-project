import 'package:ditonton/data/models/movie_detail_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieDetailTable = MovieDetailTable(
  adult: false,
  backdropPath: 'backdropPath',
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieDetailMap = {
  'adult': false,
  'backdropPath': 'backdropPath',
  'id': 1,
  'originalTitle': 'originalTitle',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'releaseDate': 'releaseDate',
  'runtime': 120,
  'title': 'title',
  'voteAverage': 1.0,
  'voteCount': 1,
};
