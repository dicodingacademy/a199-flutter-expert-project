import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/series_recommendation/series_recommendation_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late SeriesRecommendationBloc seriesRecommendationBloc;

  const testId = 1;

  setUp(() {
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    seriesRecommendationBloc =
        SeriesRecommendationBloc(mockGetSeriesRecommendations);
  });

  test('the initial state should be empty', () {
    expect(seriesRecommendationBloc.state, SeriesRecommendationEmpty());
  });

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testSeriesList));
      return seriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnSeriesRecommendation(testId)),
    expect: () => [
      SeriesRecommendationLoading(),
      SeriesRecommendationHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(testId));
      return OnSeriesRecommendation(testId).props;
    },
  );

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnSeriesRecommendation(testId)),
    expect: () => [
      SeriesRecommendationLoading(),
      SeriesRecommendationError('Server Failure'),
    ],
    verify: (bloc) => SeriesRecommendationLoading(),
  );

  blocTest<SeriesRecommendationBloc, SeriesRecommendationState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return seriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(OnSeriesRecommendation(testId)),
    expect: () => [
      SeriesRecommendationLoading(),
      SeriesRecommendationEmpty(),
    ],
  );
}
