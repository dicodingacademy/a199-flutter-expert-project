import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
