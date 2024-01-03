import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: '/daqQkmsrwwO3W8RV5hsmMaGU0bx.jpg',
    genreIds: [16, 10759, 10765],
    id: 82895,
    originCountry: ["JP"],
    originalLanguage: "ja",
    originalName: "SSSS.GRIDMAN",
    overview:
        "Tsuburaya Pro, Takara and Trigger joint venture and direct sequel to the 1993 tokusatsu series 'Denkou Choujin Gridman'.Yuta Hibiki can't remember who he is, and now he's seeing and hearing things that others don't! A voice from an old computer tells him to remember his calling, and he sees a massive, unmoving creature in the distance.",
    popularity: 219.727,
    posterPath: "/4l9EA3CCn9BQi95Rj2xlj5PSZB.jpg",
    firstAirDate: "2018-10-07",
    name: "SSSS.GRIDMAN",
    voteAverage: 7.3,
    voteCount: 74,
  );
  final ttTvSeriesList = <TvSeries>[tTvSeries];
  final tQuery = 'gridman';

  group('search TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(ttTvSeriesList));
      // act
      provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(ttTvSeriesList));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, ttTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
