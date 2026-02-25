// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_image_entity.dart';

class BreedImageModel extends BreedImageEntity {
  final String id;
  final int width;
  final int height;
  final String url;

  const BreedImageModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  }) : super(id: id, url: url);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'width': width,
      'height': height,
      'url': url,
    };
  }

  factory BreedImageModel.fromMap(Map<String, dynamic> map) {
    return BreedImageModel(
      id: map['id'] as String,
      width: map['width'] as int,
      height: map['height'] as int,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BreedImageModel.fromJson(String source) =>
      BreedImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
