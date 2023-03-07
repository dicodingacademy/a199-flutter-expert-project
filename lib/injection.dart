import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:ditonton/presentation/bloc/series_recommendation/series_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/series_watchlist/series_watchlist_bloc.dart';
// import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ditonton/common/ssl_pinning/ssl_pinning.dart';
import 'package:ditonton/common/network_info.dart';

final locator = GetIt.instance;

void init() {
  ///bloc movie
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));

  ///tv bloc
  locator.registerFactory(() => NowPlayingSeriesBloc(locator()));
  locator.registerFactory(() => PopularSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedSeriesBloc(locator(),));
  locator.registerFactory(() => SeriesRecommendationBloc(locator(),));
  locator.registerFactory(() => SeriesDetailBloc(locator(),));

  ///search bloc
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => SearchSeriesBloc(locator()));

  ///watchlist bloc
  locator.registerFactory(() => MovieWatchListBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));

  locator.registerFactory(() => SeriesWatchListBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));

  // use case
  // movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // series
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  // movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // series
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  // movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // series
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingleton(() => SSLPinning.client);
}
