import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final int id;
  final String title;
  final String thumbnail; 

  const Comic({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, thumbnail];
}