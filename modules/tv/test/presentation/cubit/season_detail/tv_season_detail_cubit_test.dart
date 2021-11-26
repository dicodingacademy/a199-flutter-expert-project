import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/season_detail_model.dart';
import 'package:tv/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_season_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailCubit bloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  const tvId = 1;
  const seasonNumber = 1;

  final tEpisodeModel = EpisodeModel(
    airDate: '2011-04-17',
    episodeNumber: 1,
    id: 1,
    name: 'Winter Is Coming',
    overview:
        'Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon\'s place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.',
    seasonNumber: seasonNumber,
    stillPath: '/bxVxZiskqu5S8ypuO6jL9JrVLuz.jpg',
    productionCode: '',
    voteAverage: 9.1,
    voteCount: 1803,
  );

  final tSeasonDetail = SeasonDetailModel(
    airDate: '2011-04-17',
    episodes: [tEpisodeModel],
    id: 1,
    name: 'Season 1',
    overview: '',
    posterPath: '/bxVxZiskqu5S8ypuO6jL9JrVLuz.jpg',
    seasonNumber: seasonNumber,
  );

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();

    bloc = TvSeasonDetailCubit(
      getTvSeasonDetail: mockGetTvSeasonDetail,
    );
  });

  void _arrangeUsecase() {
    when(mockGetTvSeasonDetail.execute(tvId, seasonNumber))
        .thenAnswer((_) async => Right(tSeasonDetail.toEntity()));
  }

  test('initial state should be [Loading]', () {
    expect(bloc.state, equals(TvSeasonDetailState.initial().copyWith()));
  });

  group('Get TvSeason Detail', () {
    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) async => cubit.fetchTvSeasonDetail(tvId, seasonNumber),
      verify: (cubit) async {
        verify(mockGetTvSeasonDetail.execute(tvId, seasonNumber));
      },
    );

    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
      'should change state to Loading when usecase is called',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) async => cubit.fetchTvSeasonDetail(tvId, seasonNumber),
      expect: () => [
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loaded,
        ),
      ],
    );

    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
      'should change TvSeason when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) async => cubit.fetchTvSeasonDetail(tvId, seasonNumber),
      expect: () => [
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loaded,
          seasonDetail: tSeasonDetail.toEntity(),
        ),
      ],
    );

    blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
      'should show episodes when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (cubit) async => cubit.fetchTvSeasonDetail(tvId, seasonNumber),
      expect: () => [
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loading,
        ),
        TvSeasonDetailState.initial().copyWith(
          state: RequestState.Loaded,
          seasonDetail: tSeasonDetail.toEntity(),
        ),
      ],
    );
  });

  blocTest<TvSeasonDetailCubit, TvSeasonDetailState>(
    'should update error message when request in successful',
    build: () {
      when(mockGetTvSeasonDetail.execute(tvId, seasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (cubit) async => cubit.fetchTvSeasonDetail(tvId, seasonNumber),
    expect: () => [
      TvSeasonDetailState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvSeasonDetailState.initial().copyWith(
        state: RequestState.Error,
        message: 'Failed',
      ),
    ],
  );
}
