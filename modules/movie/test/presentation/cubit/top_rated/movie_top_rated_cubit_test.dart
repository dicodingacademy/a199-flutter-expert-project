import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import './movie_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedCubit bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieTopRatedCubit(getTopRatedMovies: mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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
      MovieTopRatedState.initial().copyWith(),
    );
  });

  blocTest<MovieTopRatedCubit, MovieTopRatedState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.fetchTopRatedMovies(),
    expect: () => [
      MovieTopRatedState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MovieTopRatedState.initial().copyWith(
        state: RequestState.Loaded,
        movies: tMovieList,
      ),
    ],
  );

  blocTest<MovieTopRatedCubit, MovieTopRatedState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.fetchTopRatedMovies(),
    expect: () => [
      MovieTopRatedState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MovieTopRatedState.initial().copyWith(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );
}
