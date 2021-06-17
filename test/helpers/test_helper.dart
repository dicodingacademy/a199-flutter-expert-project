import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([MovieRepository, MovieRemoteDataSource],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}
