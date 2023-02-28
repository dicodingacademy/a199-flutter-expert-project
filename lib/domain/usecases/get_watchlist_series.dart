import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistSeries {
  final SeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
