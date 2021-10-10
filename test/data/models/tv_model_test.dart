import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    id: 1,
    name: 'Doraemon',
    posterPath:
        'https://image.tmdb.org/t/p/w500/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg',
    backdropPath:
        'https://image.tmdb.org/t/p/w500/jyw8VKYEiM1UDzPB7NsisUgBeJ8.jpg',
    overview: 'Doraemon is a movie about a robot who is a hero to humans.',
    voteAverage: 8.5,
    voteCount: 1000,
    popularity: 8.5,
    firstAirDate: '2019-01-01',
    genreIds: [28, 12, 16, 35, 10751],
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'ドラえもん',
  );

  final tMovie = Tv(
    id: 1,
    name: 'Doraemon',
    posterPath:
        'https://image.tmdb.org/t/p/w500/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg',
    backdropPath:
        'https://image.tmdb.org/t/p/w500/jyw8VKYEiM1UDzPB7NsisUgBeJ8.jpg',
    overview: 'Doraemon is a movie about a robot who is a hero to humans.',
    voteAverage: 8.5,
    voteCount: 1000,
    popularity: 8.5,
    firstAirDate: '2019-01-01',
    genreIds: [28, 12, 16, 35, 10751],
    originCountry: ['JP'],
    originalLanguage: 'ja',
    originalName: 'ドラえもん',
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();

    expect(result, tMovie);
  });
}
