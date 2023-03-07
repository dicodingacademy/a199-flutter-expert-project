import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/search_series/search_series_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main(){
  late MockSearchSeries mockSearchSeries;
  late SearchSeriesBloc tvSearchBloc;

  setUp((){
    mockSearchSeries = MockSearchSeries();
    tvSearchBloc = SearchSeriesBloc(mockSearchSeries);
  });

  const testQuery = 'Money Heist';

  test('the initial state should be Initial state', () {
    expect(tvSearchBloc.state, SearchSeriesInitial());
  });

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'should emit HasData state when data successfully fetched',
    build: () {
      when(mockSearchSeries.execute(testQuery)).thenAnswer((_) async => Right(testSeriesList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQuerySeriesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchSeriesEmpty(),
      SearchSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(testQuery));
      return OnQuerySeriesChange(testQuery).props;
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'should emit Error state when the searched data failed to fetch',
    build: () {
      when(mockSearchSeries.execute(testQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQuerySeriesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchSeriesEmpty(),
      SearchSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(testQuery));
      return SearchSeriesLoading().props;
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'should emit Empty state when the searched data is empty',
    build: () {
      when(mockSearchSeries.execute(testQuery)).thenAnswer((_) async => const Right([]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQuerySeriesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchSeriesEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(testQuery));
    },
  );
}