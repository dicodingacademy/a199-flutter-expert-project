import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/usecases/get_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetPopularSeries,
  GetNowPlayingSeries,
  GetTopRatedSeries,
  GetSeriesRecommendations,
  GetWatchlistSeries,
  GetWatchListStatusSeries,
  RemoveWatchlistSeries,
  SaveWatchlistSeries,
  SearchSeries,
])
void main() {}
