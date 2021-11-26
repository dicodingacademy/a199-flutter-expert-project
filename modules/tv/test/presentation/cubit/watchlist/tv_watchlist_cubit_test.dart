import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tv/domain/usecases/watchlist/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  late TvWatchlistCubit bloc;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();

    bloc = TvWatchlistCubit(
      getWatchlistTvs: mockGetWatchlistTvs,
    );
  });

  test('state should be initial', () async {
    expect(
      bloc.state,
      TvWatchlistState.initial().copyWith(),
    );
  });

  blocTest<TvWatchlistCubit, TvWatchlistState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return bloc;
    },
    act: (bloc) => bloc.fetchWatchlistTvs(),
    expect: () => [
      TvWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loading,
      ),
      TvWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loaded,
        watchlistTvs: [testWatchlistTv],
      ),
    ],
  );

  blocTest<TvWatchlistCubit, TvWatchlistState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return bloc;
    },
    act: (bloc) => bloc.fetchWatchlistTvs(),
    expect: () => [
      TvWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loading,
      ),
      TvWatchlistState.initial().copyWith(
        watchlistState: RequestState.Error,
        message: "Can't get data",
      ),
    ],
  );
}
