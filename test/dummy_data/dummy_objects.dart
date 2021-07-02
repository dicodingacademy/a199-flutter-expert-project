import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  budget: 100,
  genres: [Genre(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  imdbId: 'imdb1',
  originalLanguage: 'en',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 12000,
  runtime: 120,
  status: 'Status',
  tagline: 'Tagline',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);
