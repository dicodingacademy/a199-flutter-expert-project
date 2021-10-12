import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/season_detail_model.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_session_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSessionDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSessionDetail(mockTvRepository);
  });

  final tId = 1;
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

  test('should get tv session detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeasonDetail(tId, seasonNumber))
        .thenAnswer((_) async => Right(tSeasonDetail.toEntity()));
    // act
    final result = await usecase.execute(tId, seasonNumber);
    // assert
    expect(result, Right(tSeasonDetail.toEntity()));
  });
}
