import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import './movie_list_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieListCubit bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieListCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

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
  final tMovieList = <Movie>[tMovie];

  test('state should be initial', () async {
    expect(bloc.state, MovieListState.initial());
  });

  group('now playing movies', () {
    blocTest<MovieListCubit, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      verify: (_) => verify(mockGetNowPlayingMovies.execute()),
    );

    blocTest<MovieListCubit, MovieListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      verify: (_) => verify(mockGetNowPlayingMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListCubit, MovieListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      verify: (_) => verify(mockGetNowPlayingMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListCubit, MovieListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      verify: (_) => verify(mockGetNowPlayingMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<MovieListCubit, MovieListState>(
      'should change state to loading when usecase is called',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      verify: (_) => verify(mockGetPopularMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListCubit, MovieListState>(
      'should change movies data when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      verify: (_) => verify(mockGetPopularMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListCubit, MovieListState>(
      'should return error when popular data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      verify: (_) => verify(mockGetPopularMovies.execute()),
      expect: () => [
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    group('top rated movies', () {
      blocTest<MovieListCubit, MovieListState>(
        'should change state to loading when usecase is called',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        verify: (_) => verify(mockGetTopRatedMovies.execute()),
        expect: () => [
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Loading,
          ),
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Loaded,
            topRatedMovies: tMovieList,
          ),
        ],
      );

      blocTest<MovieListCubit, MovieListState>(
        'should change movies data when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        verify: (_) => verify(mockGetTopRatedMovies.execute()),
        expect: () => [
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Loading,
          ),
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Loaded,
            topRatedMovies: tMovieList,
          ),
        ],
      );

      blocTest<MovieListCubit, MovieListState>(
        'should return error when data is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.fetchTopRatedMovies(),
        verify: (_) => verify(mockGetTopRatedMovies.execute()),
        expect: () => [
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Loading,
          ),
          MovieListState.initial().copyWith(
            topRatedMoviesState: RequestState.Error,
            message: 'Server Failure',
          ),
        ],
      );
    });
  });
}
