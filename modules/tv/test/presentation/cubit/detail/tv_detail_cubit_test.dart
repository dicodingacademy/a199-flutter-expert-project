import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/usecases/watchlist/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/watchlist/remove_tv_watchlist.dart';
import 'package:tv/domain/usecases/watchlist/save_tv_watchlist.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailCubit bloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchListStatus mockGetWatchlistStatus;
  late MockSaveTvWatchlist mockSaveWatchlist;
  late MockRemoveTvWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetTvWatchListStatus();
    mockSaveWatchlist = MockSaveTvWatchlist();
    mockRemoveWatchlist = MockRemoveTvWatchlist();
    bloc = TvDetailCubit(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tTv = Tv(
    id: 1,
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

  final tTvList = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  test('state should be initial', () async {
    expect(bloc.state, TvDetailState.initial());
  });

  group('Get Tv Detail', () {
    blocTest<TvDetailCubit, TvDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (bloc) async => bloc.fetchTvDetail(tId),
      expect: () => [
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loading,
        ),
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          tvRecommendations: [],
        ),
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: tTvList,
        ),
      ],
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should update error message when request in unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) async => bloc.fetchTvDetail(tId),
      expect: () => [
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loading,
        ),
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
        ),
        TvDetailState.initial().copyWith(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );

    group('Watchlist', () {
      blocTest<TvDetailCubit, TvDetailState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.loadWatchlistStatus(1),
        expect: () => [
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: true,
          ),
        ],
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testTvDetail),
        verify: (_) => verify(mockSaveWatchlist.execute(testTvDetail)),
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) async => bloc.removeFromWatchlist(testTvDetail),
        verify: (_) => verify(mockRemoveWatchlist.execute(testTvDetail)),
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'should update watchlist status when add watchlist success',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testTvDetail),
        expect: () => [
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: true,
            watchlistMessage: 'Added to Watchlist',
          ),
        ],
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testTvDetail),
        expect: () => [
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
        ],
      );

      blocTest<TvDetailCubit, TvDetailState>(
        'should update watchlist message when remove watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.removeFromWatchlist(testTvDetail),
        expect: () => [
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          TvDetailState.initial().copyWith(
            isAddedToWatchlist: true,
            watchlistMessage: 'Failed',
          ),
        ],
      );

      group('on Error', () {
        blocTest<TvDetailCubit, TvDetailState>(
          'should return error when data is unsuccessful',
          build: () {
            when(mockGetTvDetail.execute(tId))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            when(mockGetTvRecommendations.execute(tId))
                .thenAnswer((_) async => Right(tTvList));
            return bloc;
          },
          act: (bloc) async => bloc.fetchTvDetail(tId),
          expect: () => [
            TvDetailState.initial().copyWith(
              tvState: RequestState.Loading,
            ),
            TvDetailState.initial().copyWith(
              tvState: RequestState.Error,
              message: 'Server Failure',
            ),
          ],
        );
      });
    });
  });
}
