import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  execute(MovieDetail movie) {}
}
