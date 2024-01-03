import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/base_item_entity.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

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

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: "/7v3bO3pNnyLHLlwETtmyQxKV2Ba.jpg",
  genreIds: [35, 10766, 18],
  id: 73362,
  name: "The Ladies' Paradise",
  overview:
      "Follow Teresa Iorio, a young woman who leaves her rural Sicilian hometown for Milan to find work--and much more--at a newly opened department store: The Ladies' Paradise.",
  popularity: 380.213,
  posterPath: '/7k0D1feQhS59O2k8xkf5UR19LUi.jpg',
  firstAirDate: "2015-12-08",
  originCountry: [ "IT"],
  originalLanguage: "it",
  originalName: "Il paradiso delle signore",
  voteAverage: 7.625,
  voteCount: 12,
);

final testTvSeriesList = [testTvSeries];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action'), Genre(id: 2, name: 'Comedy'), Genre(id: 3, name: 'Romance')],
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

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  episodeRunTime: null,
  name: "title",
  popularity: 380.213,
  status: "Returning Series",
  tagline: "",
  voteAverage: 1,
  voteCount: 1,
);


final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
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
  'category': ItemType.movie.toString()
};

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);


final testTvSeriesTable = TvSeriesTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': ItemType.tvSeries.toString()
};
