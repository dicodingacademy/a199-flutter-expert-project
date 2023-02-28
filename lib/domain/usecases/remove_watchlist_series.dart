import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class RemoveWatchlist {
  final SeriesRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.removeWatchlist(series);
  }
}
