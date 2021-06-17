import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  final tId = 1;
  final tMovie = MovieDetail<Genre>(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100,
    genres: [Genre(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    imdbId: 'imdb1',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 12000,
    runtime: 120,
    status: 'Status',
    tagline: 'Tagline',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(tId))
        .thenAnswer((_) async => Right(tMovie));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tMovie));
  });
}
