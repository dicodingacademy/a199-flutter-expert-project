import 'package:core/core.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        BlocProvider(
          create: (_) => di.locator<MovieListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistCubit>(),
        ),

        // tvs
        BlocProvider(
          create: (_) => di.locator<TvListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeasonDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistCubit>(),
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
