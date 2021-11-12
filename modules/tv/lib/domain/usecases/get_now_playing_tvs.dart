import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetNowPlayingTvs {
  final TvRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
