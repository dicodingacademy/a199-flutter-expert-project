import 'package:ditonton/domain/repositories/series_repository.dart';

class GetWatchListStatusSeries {
  final SeriesRepository repository;

  GetWatchListStatusSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
