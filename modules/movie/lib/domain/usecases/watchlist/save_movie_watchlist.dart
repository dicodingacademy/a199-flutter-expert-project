import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class SaveMovieWatchlist {
  final MovieRepository repository;

  SaveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
