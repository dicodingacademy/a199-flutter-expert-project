import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/series_watchlist/series_watchlist_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late MockGetWatchListStatusSeries mockGetWatchListStatus;
  late MockRemoveWatchlistSeries mockRemoveWatchlist;
  late MockSaveWatchlistSeries mockSaveWatchlist;
  late SeriesWatchListBloc seriesWatchListBloc;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlistSeries();
    mockRemoveWatchlist = MockRemoveWatchlistSeries();
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    mockGetWatchListStatus = MockGetWatchListStatusSeries();
    seriesWatchListBloc = SeriesWatchListBloc(
      mockGetWatchlistSeries,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(seriesWatchListBloc.state, SeriesWatchListInitial());
  });

  group('get watchlist seriess test cases', () {
      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistSeries.execute())
              .thenAnswer((_) async => Right([testWatchlistSeries]));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchSeriesWatchList()),
        expect: () => [
          SeriesWatchListLoading(),
          SeriesWatchListHasData([testWatchlistSeries]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistSeries.execute());
          return OnFetchSeriesWatchList().props;
        },
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistSeries.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchSeriesWatchList()),
        expect: () => [
          SeriesWatchListLoading(),
          SeriesWatchListError('Server Failure'),
        ],
        verify: (bloc) => SeriesWatchListLoading(),
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistSeries.execute())
              .thenAnswer((_) async => const Right([]));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchSeriesWatchList()),
        expect: () => [
          SeriesWatchListLoading(),
          SeriesWatchListEmpty(),
        ],
      );
    },
  );

  group('get watchlist status test cases', () {
      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListStatus.execute(testSeriesDetail.id))
              .thenAnswer((_) async => true);
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListStatus(testSeriesDetail.id)),
        expect: () => [
          SeriesWatchListIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testSeriesDetail.id));
          return SeriesWatchListStatus(testSeriesDetail.id).props;
        },
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testSeriesDetail.id))
              .thenAnswer((_) async => false);
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListStatus(testSeriesDetail.id)),
        expect: () => [
          SeriesWatchListIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testSeriesDetail.id));
          return SeriesWatchListStatus(testSeriesDetail.id).props;
        },
      );
    },
  );

  group('add and remove watchlist test cases', () {
      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlist.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("addMessage"));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListAdd(testSeriesDetail)),
        expect: () => [
          SeriesWatchListMessage("addMessage"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testSeriesDetail));
          return SeriesWatchListAdd(testSeriesDetail).props;
        },
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListAdd(testSeriesDetail)),
        expect: () => [
          SeriesWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testSeriesDetail));
          return SeriesWatchListAdd(testSeriesDetail).props;
        },
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlist.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("removeMessage"));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListRemove(testSeriesDetail)),
        expect: () => [
          SeriesWatchListMessage("removeMessage"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testSeriesDetail));
          return SeriesWatchListRemove(testSeriesDetail).props;
        },
      );

      blocTest<SeriesWatchListBloc, SeriesWatchListState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return seriesWatchListBloc;
        },
        act: (bloc) => bloc.add(SeriesWatchListRemove(testSeriesDetail)),
        expect: () => [
          SeriesWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testSeriesDetail));
          return SeriesWatchListRemove(testSeriesDetail).props;
        },
      );
    },
  );
}
