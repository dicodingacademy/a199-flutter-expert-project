import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:ditonton/presentation/provider/tv/tv_session_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_session_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailNotifier provider;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  late int listenerCallCount;

  final tvId = 1;
  final seasonNumber = 1;

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
    listenerCallCount = 0;
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();

    provider = TvSeasonDetailNotifier(
      getTvSeasonDetail: mockGetTvSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  void _arrangeUsecase() {
    when(mockGetTvSeasonDetail.execute(tvId, seasonNumber))
        .thenAnswer((_) async => Right(tSeasonDetail.toEntity()));
  }

  group('Get TvSeason Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tvId, seasonNumber);
      // assert
      verify(mockGetTvSeasonDetail.execute(tvId, seasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeasonDetail(tvId, seasonNumber);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TvSeason when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tvId, seasonNumber);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.seasonDetail, tSeasonDetail.toEntity());
      expect(listenerCallCount, 2);
    });

    test('should show episodes when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tvId, seasonNumber);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.seasonDetail.episodes, [tEpisodeModel.toEntity()]);
    });
  });

  test('should update error message when request in successful', () async {
    // arrange
    when(mockGetTvSeasonDetail.execute(tvId, seasonNumber))
        .thenAnswer((_) async => Left(ServerFailure('Failed')));
    // act
    await provider.fetchTvSeasonDetail(tvId, seasonNumber);
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Failed');
  });
}
