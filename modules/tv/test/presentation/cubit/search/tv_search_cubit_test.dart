import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tvs.dart';
import 'package:tv/tv.dart';

import 'tv_search_cubit_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvs;
  late TvSearchCubit bloc;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    bloc = TvSearchCubit(searchTvs: mockSearchTvs);
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

  test('initial state should be empty', () {
    expect(bloc.state, TvSearchState.initial().copyWith());
  });

  blocTest<TvSearchCubit, TvSearchState>(
    'should search for movies',
    build: () {
      when(mockSearchTvs.execute("q")).thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) async => bloc.fetchTvSearch("q"),
    expect: () => [
      TvSearchState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvSearchState.initial().copyWith(
        state: RequestState.Loaded,
        searchResult: tTvList,
      ),
    ],
  );

  blocTest<TvSearchCubit, TvSearchState>(
    'should emit error when search for movies fails',
    build: () {
      when(mockSearchTvs.execute("q"))
          .thenAnswer((_) async => Left(ServerFailure("error")));
      return bloc;
    },
    act: (bloc) async => bloc.fetchTvSearch("q"),
    expect: () => [
      TvSearchState.initial().copyWith(
        state: RequestState.Loading,
      ),
      TvSearchState.initial().copyWith(
        state: RequestState.Error,
        message: "error",
      ),
    ],
  );
}
