import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  CustomDrawer({
    required this.content,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
           currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              _animationController.reverse();
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              _animationController.reverse();
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}
	