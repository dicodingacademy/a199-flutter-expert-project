import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_helper_test.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late MovieWatchListBloc movieWatchListBloc;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchListBloc = MovieWatchListBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(movieWatchListBloc.state, MovieWatchListInitial());
  });

  group('get watchlist movies test cases', () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchList()),
        expect: () => [
          MovieWatchListLoading(),
          MovieWatchListHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
          return OnFetchMovieWatchList().props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchList()),
        expect: () => [
          MovieWatchListLoading(),
          MovieWatchListError('Server Failure'),
        ],
        verify: (bloc) => MovieWatchListLoading(),
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchList()),
        expect: () => [
          MovieWatchListLoading(),
          MovieWatchListEmpty(),
        ],
      );
    },
  );

  group('get watchlist status test cases', () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MovieWatchListIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MovieWatchListStatus(testMovieDetail.id).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListStatus(testMovieDetail.id)),
        expect: () => [
          MovieWatchListIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return MovieWatchListStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group('add and remove watchlist test cases', () {
      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("addMessage"));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListAdd(testMovieDetail)),
        expect: () => [
          MovieWatchListMessage("addMessage"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return MovieWatchListAdd(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListAdd(testMovieDetail)),
        expect: () => [
          MovieWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return MovieWatchListAdd(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("removeMessage"));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListRemove(testMovieDetail)),
        expect: () => [
          MovieWatchListMessage("removeMessage"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return MovieWatchListRemove(testMovieDetail).props;
        },
      );

      blocTest<MovieWatchListBloc, MovieWatchListState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return movieWatchListBloc;
        },
        act: (bloc) => bloc.add(MovieWatchListRemove(testMovieDetail)),
        expect: () => [
          MovieWatchListError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return MovieWatchListRemove(testMovieDetail).props;
        },
      );
    },
  );
}
