import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import '../../utils/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovie();
  }
}
