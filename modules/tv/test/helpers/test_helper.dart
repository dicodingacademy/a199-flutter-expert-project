import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/watchlist_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';

import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRemoteDataSource,
  TvRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
