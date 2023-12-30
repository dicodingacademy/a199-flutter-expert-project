import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetWatchListMovieStatus {
  final MovieRepository repository;

  GetWatchListMovieStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
