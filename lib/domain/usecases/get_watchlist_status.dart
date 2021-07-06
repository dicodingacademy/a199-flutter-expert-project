import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<Either<Failure, bool>> execute(MovieDetail movie) async {
    return repository.getWatchlistStatus(movie.id);
  }
}
