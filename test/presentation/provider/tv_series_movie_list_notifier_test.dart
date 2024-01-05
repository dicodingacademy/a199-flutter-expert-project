import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/provider/home_tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

void main() {
  late MockGetOnAirTvSeries mockGetNowPlayingMovies;
  late HomeTvSeriesListNotifier notifier;
  late int listenerCallCount;


  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetOnAirTvSeries();
    notifier = HomeTvSeriesListNotifier(mockGetNowPlayingMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    originCountry: ["US"],
    originalLanguage: "en",
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchOnAirTvSeries();
    // assert
    expect(notifier.homelistState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchOnAirTvSeries();
    // assert
    expect(notifier.homelistState, RequestState.Loaded);
    expect(notifier.homeList, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchOnAirTvSeries();
    // assert
    expect(notifier.homelistState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}