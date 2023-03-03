import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

final testSeries = Series(
  backdropPath: '/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg',
  genreIds: [18, 10759],
  id: 100088,
  name: 'The Last of Us',
  originCountry: ['US'],
  originalLanguage: 'en',
  originalName: 'The Last of Us',
  overview:
      'Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.',
  popularity: 4703.161,
  posterPath: '/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg',
  voteAverage: 8.797,
  voteCount: 2180,
);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
  adult: true,
  backdropPath: '/uDgy6hyPd82kOHh6I95FLtLnj6p.jpg',
  genres: [Genre(id: 18, name: 'Drama')],
  id: 100088,
  name: 'The Last of Us',
  numberOfEpisodes: 9,
  numberOfSeasons: 1,
  originalName: 'The Last of Us',
  overview: 'Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.',
  popularity: 4703.161,
  posterPath: '/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg',
  seasons: [Season(
    episodeCount: 9,
    id: 144593,
    name: "Season 1",
    overview: "",
    posterPath: "/aUQKIpZZ31KWbpdHMCmaV76u78T.jpg",
    seasonNumber: 1
  )],
  voteAverage: 8.797,
  voteCount: 2180,
);

final testWatchlistSeries = Series.watchlist(
  id: 100088,
  name: 'The Last of Us',
  posterPath: '/aUQKIpZZ31KWbpdHMCmaV76u78T.jpg',
  overview: 'Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.',
);

final testSeriesTable = SeriesTable(
  id: 100088,
  name: 'The Last of Us',
  posterPath: '/aUQKIpZZ31KWbpdHMCmaV76u78T.jpg',
  overview: 'Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.',
);

final testSeriesMap = {
  "id": 100088,
  "overview": "Twenty years after modern civilization has been destroyed, Joel, a hardened survivor, is hired to smuggle Ellie, a 14-year-old girl, out of an oppressive quarantine zone. What starts as a small job soon becomes a brutal, heartbreaking journey, as they both must traverse the United States and depend on each other for survival.",
  "posterPath": "/aUQKIpZZ31KWbpdHMCmaV76u78T.jpg",
  "name": "The Last of Us",
};
