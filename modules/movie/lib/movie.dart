library movie;

export './data/datasources/movie_remote_data_source.dart';
export './data/models/movie_detail_model.dart';
export './data/models/movie_model.dart';
export './data/models/movie_response.dart';
export './data/repositories/movie_repository_impl.dart';

export './domain/entities/movie.dart';
export './domain/entities/movie_detail.dart';
export './domain/repositories/movie_repository.dart';

export './domain/usecases/watchlist/get_movie_watchlist_status.dart';
export './domain/usecases/watchlist/get_watchlist_movies.dart';
export './domain/usecases/watchlist/remove_movie_watchlist.dart';
export './domain/usecases/watchlist/save_movie_watchlist.dart';
export './domain/usecases/get_movie_detail.dart';
export './domain/usecases/get_movie_recommendations.dart';
export './domain/usecases/get_now_playing_movies.dart';
export './domain/usecases/get_popular_movies.dart';
export './domain/usecases/get_top_rated_movies.dart';
export './domain/usecases/search_movies.dart';

export './presentation/provider/movie_detail_notifier.dart';
export './presentation/provider/movie_list_notifier.dart';
export './presentation/provider/movie_search_notifier.dart';
export './presentation/provider/popular_movies_notifier.dart';
export './presentation/provider/top_rated_movies_notifier.dart';
export './presentation/provider/watchlist_movie_notifier.dart';

export './presentation/pages/home_movie_page.dart';
export './presentation/pages/movie_detail_page.dart';
export './presentation/pages/movie_search_page.dart';
export './presentation/pages/popular_movies_page.dart';
export './presentation/pages/top_rated_movies_page.dart';
export './presentation/pages/watchlist_movies_page.dart';
