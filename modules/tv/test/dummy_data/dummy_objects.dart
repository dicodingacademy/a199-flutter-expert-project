import 'package:core/data/models/watchlist_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

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
