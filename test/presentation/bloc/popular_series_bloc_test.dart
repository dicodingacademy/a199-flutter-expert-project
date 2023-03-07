import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/popular_series/popular_series_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc seriesPopularBloc;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    seriesPopularBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  test('the initial state should be empty', () {
    expect(seriesPopularBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return seriesPopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
      return OnPopularSeries().props;
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesPopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularSeriesLoading(),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return seriesPopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesEmpty(),
    ],
  );
}
