import 'package:dartz/dartz.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';
import '../../utils/failure.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
