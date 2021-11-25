import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import './movie_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularCubit bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = MoviePopularCubit(mockGetPopularMovies);
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
    expect(
      bloc.state,
      MoviePopularState.initial().copyWith(),
    );
  });

  blocTest<MoviePopularCubit, MoviePopularState>(
    'should change state to loading when usecase is called',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.fetchPopularMovies(),
    expect: () => [
      MoviePopularState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MoviePopularState.initial().copyWith(
        state: RequestState.Loaded,
        movies: tMovieList,
      ),
    ],
  );

  blocTest<MoviePopularCubit, MoviePopularState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.fetchPopularMovies(),
    expect: () => [
      MoviePopularState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MoviePopularState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
