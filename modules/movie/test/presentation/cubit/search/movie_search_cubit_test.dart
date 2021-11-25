import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/movie.dart';

import 'movie_search_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchCubit bloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchCubit(searchMovies: mockSearchMovies);
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

  test('initial state should be empty', () {
    expect(bloc.state, MovieSearchState.initial().copyWith());
  });

  blocTest<MovieSearchCubit, MovieSearchState>(
    'should search for movies',
    build: () {
      when(mockSearchMovies.execute("q"))
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) async => bloc.fetchMovieSearch("q"),
    expect: () => [
      MovieSearchState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MovieSearchState.initial().copyWith(
        state: RequestState.Loaded,
        searchResult: tMovieList,
      ),
    ],
  );

  blocTest<MovieSearchCubit, MovieSearchState>(
    'should emit error when search for movies fails',
    build: () {
      when(mockSearchMovies.execute("q"))
          .thenAnswer((_) async => Left(ServerFailure("error")));
      return bloc;
    },
    act: (bloc) async => bloc.fetchMovieSearch("q"),
    expect: () => [
      MovieSearchState.initial().copyWith(
        state: RequestState.Loading,
      ),
      MovieSearchState.initial().copyWith(
        state: RequestState.Error,
        message: "error",
      ),
    ],
  );
}
