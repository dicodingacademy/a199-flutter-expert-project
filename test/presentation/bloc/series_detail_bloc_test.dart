import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/series_detail/series_detail_bloc.dart';
import '../../dummy_data/dummy_object_series.dart';
import '../../helpers/series_helper_test.mocks.dart';

void main() {
  late MockGetSeriesDetail mockGetSeriesDetail;
  late SeriesDetailBloc seriesDetailBloc;

  const testId = 1;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    seriesDetailBloc = SeriesDetailBloc(mockGetSeriesDetail);
  });

  test('the initial state should be empty', () {
    expect(seriesDetailBloc.state, SeriesDetailEmpty());
  });
  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesDetail.execute(testId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return seriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnSeriesDetail(testId)),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(testId));
      return OnSeriesDetail(testId).props;
    },
  );

  blocTest<SeriesDetailBloc, SeriesDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesDetailBloc;
    },
    act: (bloc) => bloc.add(OnSeriesDetail(testId)),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailError('Server Failure'),
    ],
    verify: (bloc) => SeriesDetailLoading(),
  );
}
