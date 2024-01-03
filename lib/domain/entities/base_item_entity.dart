// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum ItemType { tvSeries, movie }

abstract class BaseItemEntity extends Equatable {
  final String? title;
  final String? overview;
  final String? posterPath;
  final int id;
  final ItemType type;

  BaseItemEntity({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.id,
    required this.type,
  });

  BaseItemEntity.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.type,
  });

  @override
  List<Object?> get props {
    return [
      title,
      overview,
      posterPath,
      id,
      type,
    ];
  }
}
