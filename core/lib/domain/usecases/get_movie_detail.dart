import 'package:dartz/dartz.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';
import '../../utils/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
