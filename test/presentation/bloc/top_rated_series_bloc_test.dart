import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesBloc seriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    seriesTopRatedBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });

  test('the initial state should be empty', () {
    expect(seriesTopRatedBloc.state, TopRatedSeriesEmpty());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return seriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
      return OnTopRatedSeries().props;
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) => TopRatedSeriesLoading(),
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return seriesTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedSeries()),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesEmpty(),
    ],
  );
}
