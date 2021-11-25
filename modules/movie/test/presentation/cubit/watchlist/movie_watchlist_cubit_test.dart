import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:movie/domain/usecases/watchlist/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import './movie_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  late MovieWatchlistCubit bloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = MovieWatchlistCubit(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  test('state should be initial', () async {
    expect(
      bloc.state,
      MovieWatchlistState.initial().copyWith(),
    );
  });

  blocTest<MovieWatchlistCubit, MovieWatchlistState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return bloc;
    },
    act: (bloc) => bloc.fetchWatchlistMovies(),
    expect: () => [
      MovieWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loading,
      ),
      MovieWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [testWatchlistMovie],
      ),
    ],
  );

  blocTest<MovieWatchlistCubit, MovieWatchlistState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return bloc;
    },
    act: (bloc) => bloc.fetchWatchlistMovies(),
    expect: () => [
      MovieWatchlistState.initial().copyWith(
        watchlistState: RequestState.Loading,
      ),
      MovieWatchlistState.initial().copyWith(
        watchlistState: RequestState.Error,
        message: "Can't get data",
      ),
    ],
  );
}
