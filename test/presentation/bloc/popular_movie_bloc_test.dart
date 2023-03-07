import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/movie_helper_test.mocks.dart';

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('the initial state should be empty', () {
    expect(moviePopularBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return OnPopularMovie().props;
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) => PopularMovieLoading(),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieEmpty(),
    ],
  );
}
