import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TvTopRatedCubit bloc;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    bloc = TvTopRatedCubit(getTopRatedTvs: mockGetTopRatedTvs);
  });

  final tTv = Tv(
    id: 1,
    name: 'test',
    posterPath: 'test',
    backdropPath: 'test',
    overview: 'test',
    firstAirDate: 'test',
    voteAverage: 1.0,
    voteCount: 1,
    genreIds: [1, 2, 3],
    originCountry: ['test'],
    originalLanguage: 'test',
    originalName: 'test',
    popularity: 1.0,
  );

  final tTvList = <Tv>[tTv];

  test('state should be initial', () async {
    expect(
      bloc.state,
      TvTopRatedState.initial().copyWith(),
    );
  });

  blocTest<TvTopRatedCubit, TvTopRatedState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.fetchTopRatedTvs(),
    expect: () => [
      TvTopRatedState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvTopRatedState.initial().copyWith(
        state: RequestState.Loaded,
        tvs: tTvList,
      ),
    ],
  );

  blocTest<TvTopRatedCubit, TvTopRatedState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.fetchTopRatedTvs(),
    expect: () => [
      TvTopRatedState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvTopRatedState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
