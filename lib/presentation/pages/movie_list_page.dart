import 'package:flutter/material.dart';

class PopularMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: ListView(),
    );
  }
}
