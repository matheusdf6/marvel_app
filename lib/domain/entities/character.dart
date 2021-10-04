import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, name, description, thumbnail ];
}
