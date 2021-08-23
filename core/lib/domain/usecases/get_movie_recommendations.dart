import 'package:dartz/dartz.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import '../../utils/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
