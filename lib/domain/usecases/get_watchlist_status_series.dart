import 'package:ditonton/domain/repositories/series_repository.dart';

class GetWatchListStatus {
  final SeriesRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
