import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/provider/home_movie_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late HomeMovieListNotifier notifier;
  late int listenerCallCount;


  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    notifier = HomeMovieListNotifier(mockGetNowPlayingMovies)
      ..addListener(() {
        listenerCallCount++;
      });
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchNowPlayingList();
    // assert
    expect(notifier.homelistState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchNowPlayingList();
    // assert
    expect(notifier.homelistState, RequestState.Loaded);
    expect(notifier.homeList, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingList();
    // assert
    expect(notifier.homelistState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}