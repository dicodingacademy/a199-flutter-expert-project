import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/usecases/watchlist/get_movie_watchlist_status.dart';
import 'package:movie/domain/usecases/watchlist/remove_movie_watchlist.dart';
import 'package:movie/domain/usecases/watchlist/save_movie_watchlist.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import './movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist,
])
void main() {
  late MovieDetailCubit bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieWatchListStatus mockGetWatchlistStatus;
  late MockSaveMovieWatchlist mockSaveWatchlist;
  late MockRemoveMovieWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetMovieWatchListStatus();
    mockSaveWatchlist = MockSaveMovieWatchlist();
    mockRemoveWatchlist = MockRemoveMovieWatchlist();
    bloc = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getMovieWatchListStatus: mockGetWatchlistStatus,
      saveMovieWatchlist: mockSaveWatchlist,
      removeMovieWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  test('state should be initial', () async {
    expect(bloc.state, MovieDetailState.initial());
  });

  group('Get Movie Detail', () {
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return bloc;
      },
      act: (bloc) async => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          movieRecommendations: [],
        ),
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: tMovies,
        ),
      ],
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should update error message when request in unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return bloc;
      },
      act: (bloc) async => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );

    group('Watchlist', () {
      blocTest<MovieDetailCubit, MovieDetailState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.loadWatchlistStatus(1),
        expect: () => [
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: true,
          ),
        ],
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testMovieDetail),
        verify: (_) => verify(mockSaveWatchlist.execute(testMovieDetail)),
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) async => bloc.removeFromWatchlist(testMovieDetail),
        verify: (_) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'should update watchlist status when add watchlist success',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testMovieDetail),
        expect: () => [
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: true,
            watchlistMessage: 'Added to Watchlist',
          ),
        ],
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) async => bloc.addWatchlist(testMovieDetail),
        expect: () => [
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
        ],
      );

      blocTest<MovieDetailCubit, MovieDetailState>(
        'should update watchlist message when remove watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) async => bloc.removeFromWatchlist(testMovieDetail),
        expect: () => [
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          MovieDetailState.initial().copyWith(
            isAddedToWatchlist: true,
            watchlistMessage: 'Failed',
          ),
        ],
      );

      group('on Error', () {
        blocTest<MovieDetailCubit, MovieDetailState>(
          'should return error when data is unsuccessful',
          build: () {
            when(mockGetMovieDetail.execute(tId))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            when(mockGetMovieRecommendations.execute(tId))
                .thenAnswer((_) async => Right(tMovies));
            return bloc;
          },
          act: (bloc) async => bloc.fetchMovieDetail(tId),
          expect: () => [
            MovieDetailState.initial().copyWith(
              movieState: RequestState.Loading,
            ),
            MovieDetailState.initial().copyWith(
              movieState: RequestState.Error,
              message: 'Server Failure',
            ),
          ],
        );
      });
    });
  });
}
