import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';

import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesBloc seriesNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    seriesNowPlayingBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  test('the initial state should be empty', () {
    expect(seriesNowPlayingBloc.state, NowPlayingSeriesEmpty());
  });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return seriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSeries.execute());
      return OnNowPlayingSeries().props;
    },
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingSeriesLoading(),
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return seriesNowPlayingBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesEmpty(),
    ],
  );
}
