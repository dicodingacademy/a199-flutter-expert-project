import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
