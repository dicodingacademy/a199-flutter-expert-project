import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'TvSeries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailNotifier tvSeriesDetailNotifier;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvSeriesDetailNotifier = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchListTvSeriesStatus,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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
  final tTvSeriess = <TvSeries>[tTvSeries];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriess));
    when(mockGetWatchListTvSeriesStatus.execute(tId))
        .thenAnswer((_) async => false);
  }

  group('Get TvSeries Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
      verify(mockGetWatchListTvSeriesStatus.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TvSeries when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.state, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.itemDetail, testTvSeriesDetail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation TvSeriess when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.state, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.recommendations, tTvSeriess);
    });
  });

  group('Get TvSeries Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendations.execute(tId));
      expect(tvSeriesDetailNotifier.recommendations, tTvSeriess);
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.recommendationState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.recommendationState, RequestState.Loaded);
      expect(tvSeriesDetailNotifier.recommendations, tTvSeriess);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetWatchListTvSeriesStatus.execute(tId))
          .thenAnswer((_) async => false);
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.recommendationState, RequestState.Error);
      expect(tvSeriesDetailNotifier.recommendationMessage, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListTvSeriesStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.loadWatchlistStatus(
        mockGetWatchListTvSeriesStatus.execute(1),
      );
      // assert
      expect(tvSeriesDetailNotifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await tvSeriesDetailNotifier.removeFromWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await tvSeriesDetailNotifier.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      verify(mockGetWatchListTvSeriesStatus.execute(testTvSeriesDetail.id));
      expect(tvSeriesDetailNotifier.isAddedToWatchlist, true);
      expect(tvSeriesDetailNotifier.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTvSeriesStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await tvSeriesDetailNotifier.addWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(tvSeriesDetailNotifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    when(mockGetWatchListTvSeriesStatus.execute(tId))
        .thenAnswer((_) async => false);
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriess));
      // act
      await tvSeriesDetailNotifier.fetchTvSeriesDetail(tId);
      // assert
      expect(tvSeriesDetailNotifier.state, RequestState.Error);
      expect(tvSeriesDetailNotifier.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });
}
