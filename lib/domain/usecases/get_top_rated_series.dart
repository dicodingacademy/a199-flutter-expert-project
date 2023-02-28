import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTopRatedSeries();
  }
}
