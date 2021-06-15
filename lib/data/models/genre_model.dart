import 'package:ditonton/domain/entities/genre.dart';

class GenreModel extends Genre {
  GenreModel({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
