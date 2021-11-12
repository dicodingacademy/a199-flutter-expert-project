import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv/tv.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // movies
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        // tvs
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeasonDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            // movies
            case MOVIE_HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case MOVIE_POPULAR_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case MOVIE_TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case MOVIE_SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case MOVIE_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            // tvs
            case TV_HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case TV_POPULAR_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TV_TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TV_SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case TV_SEASON_DETAIL_ROUTE:
              final id = (settings.arguments! as Map)['id'];
              final seasonNumber = (settings.arguments! as Map)['seasonNumber'];

              return MaterialPageRoute(
                builder: (_) =>
                    TvSeasonDetailPage(id: id, seasonNumber: seasonNumber),
              );
            case TV_WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());

            // others
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
