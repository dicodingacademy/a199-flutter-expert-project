import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'tv_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late TvPopularCubit bloc;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    bloc = TvPopularCubit(mockGetPopularTvs);
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
      TvPopularState.initial().copyWith(),
    );
  });

  blocTest<TvPopularCubit, TvPopularState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.fetchPopularTvs(),
    expect: () => [
      TvPopularState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvPopularState.initial().copyWith(
        state: RequestState.Loaded,
        tvs: tTvList,
      ),
    ],
  );

  blocTest<TvPopularCubit, TvPopularState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.fetchPopularTvs(),
    expect: () => [
      TvPopularState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvPopularState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
