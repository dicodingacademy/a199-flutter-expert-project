import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

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

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// Tvs
final testTv = Tv(
  id: 2,
  name: 'test',
  posterPath: 'test',
  backdropPath: 'test',
  overview: 'test',
  firstAirDate: 'test',
  voteAverage: 1.0,
  voteCount: 1,
  genreIds: [1, 2, 3],
  originCountry: ['test'],
  originalLanguage: 'test',
  originalName: 'test',
  popularity: 1.0,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  id: 2,
  name: 'test',
  posterPath: 'test',
  backdropPath: 'test',
  overview: 'test',
  firstAirDate: 'test',
  voteAverage: 1.0,
  voteCount: 1,
  originCountry: ['test'],
  originalLanguage: 'test',
  originalName: 'test',
  popularity: 1.0,
  languages: ['test'],
  episodeRunTime: [1],
  genres: [Genre(id: 1, name: 'test')],
  seasons: [
    Season(
      airDate: 'test',
      episodeCount: 1,
      id: 1,
      name: 'test',
      overview: 'test',
      posterPath: 'test',
      seasonNumber: 1,
    )
  ],
  homepage: 'test',
  inProduction: true,
  lastAirDate: 'test',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  status: 'test',
  tagline: 'test',
  type: 'test',
);

final testWatchlistTv = Tv.watchlist(
  id: 2,
  name: 'test',
  posterPath: 'test',
  overview: 'test',
);

final testTvTable = WatchlistTable(
  id: 2,
  title: 'test',
  posterPath: 'test',
  overview: 'test',
);

final testTvMap = {
  'id': 2,
  'overview': 'test',
  'posterPath': 'test',
  'title': 'test',
};
