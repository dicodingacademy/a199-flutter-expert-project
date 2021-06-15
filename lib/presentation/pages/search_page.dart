import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: Theme.of(context).textTheme.headline6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = data.searchResult[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieDetailPage.ROUTE_NAME,
                                arguments: movie.id,
                              );
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Card(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 16 + 80 + 16,
                                      bottom: 8,
                                      right: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          movie.overview,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 16,
                                    bottom: 16,
                                  ),
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$BASE_IMAGE_URL${movie.posterPath}',
                                      width: 80,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(child: Placeholder());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
