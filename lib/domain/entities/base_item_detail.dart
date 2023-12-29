// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/genre.dart';

class BaseItemDetail extends Equatable {
  final String title;
  final String overview;
  final String posterPath;
  final int id;
  final List<Genre> genres;
  final int runtime;
  final double voteAverage;

  BaseItemDetail({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.id,
    required this.genres,
    required this.runtime,
    required this.voteAverage,
  });

  @override
  List<Object> get props {
    return [
      title,
      overview,
      posterPath,
      id,
      genres,
      runtime,
      voteAverage,
    ];
  }
}
