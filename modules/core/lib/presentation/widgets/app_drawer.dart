import 'package:core/common/routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushReplacementNamed(context, MOVIE_HOME_ROUTE);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Shows'),
            onTap: () {
              Navigator.pushReplacementNamed(context, TV_HOME_ROUTE);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Movies Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, MOVIE_WATCHLIST_ROUTE);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Tvs Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, TV_WATCHLIST_ROUTE);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
