import 'package:equatable/equatable.dart';

class BreedImageEntity extends Equatable {
  final String id;
  final String url;

  const BreedImageEntity({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];
}
