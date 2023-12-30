import 'package:equatable/equatable.dart';

class BaseTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? category;

  BaseTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'category': category,
      };

  @override
  List<Object?> get props => [id, title, posterPath, overview, category];
}
