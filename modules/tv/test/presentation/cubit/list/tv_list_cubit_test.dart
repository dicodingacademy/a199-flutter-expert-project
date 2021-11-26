import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tvs.dart';
import 'package:core/common/failure.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_list_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvs,
  GetPopularTvs,
  GetTopRatedTvs,
])
void main() {
  late TvListCubit bloc;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    bloc = TvListCubit(
      getNowPlayingTvs: mockGetNowPlayingTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    );
  });

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

  test('state should be initial', () async {
    expect(bloc.state, TvListState.initial());
  });

  group('now playing movies', () {
    blocTest<TvListCubit, TvListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingTvs(),
      verify: (_) => verify(mockGetNowPlayingTvs.execute()),
    );

    blocTest<TvListCubit, TvListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingTvs(),
      verify: (_) => verify(mockGetNowPlayingTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: tTvList,
        ),
      ],
    );

    blocTest<TvListCubit, TvListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingTvs(),
      verify: (_) => verify(mockGetNowPlayingTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvs: tTvList,
        ),
      ],
    );

    blocTest<TvListCubit, TvListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingTvs(),
      verify: (_) => verify(mockGetNowPlayingTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<TvListCubit, TvListState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularTvs(),
      verify: (_) => verify(mockGetPopularTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Loaded,
          popularTvs: tTvList,
        ),
      ],
    );

    blocTest<TvListCubit, TvListState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularTvs(),
      verify: (_) => verify(mockGetPopularTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Loaded,
          popularTvs: tTvList,
        ),
      ],
    );

    blocTest<TvListCubit, TvListState>(
      'should return error when popular data is unsuccessful',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularTvs(),
      verify: (_) => verify(mockGetPopularTvs.execute()),
      expect: () => [
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Loading,
        ),
        TvListState.initial().copyWith(
          popularTvsState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    group('top rated movies', () {
      blocTest<TvListCubit, TvListState>(
        'should change state to loading when usecase is called',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Right(tTvList));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedTvs(),
        verify: (_) => verify(mockGetTopRatedTvs.execute()),
        expect: () => [
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Loading,
          ),
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Loaded,
            topRatedTvs: tTvList,
          ),
        ],
      );

      blocTest<TvListCubit, TvListState>(
        'should change movies data when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Right(tTvList));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedTvs(),
        verify: (_) => verify(mockGetTopRatedTvs.execute()),
        expect: () => [
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Loading,
          ),
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Loaded,
            topRatedTvs: tTvList,
          ),
        ],
      );

      blocTest<TvListCubit, TvListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetTopRatedTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedTvs(),
        verify: (_) => verify(mockGetTopRatedTvs.execute()),
        expect: () => [
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Loading,
          ),
          TvListState.initial().copyWith(
            topRatedTvsState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });
}
