import 'package:equatable/equatable.dart';

import 'breed_image_entity.dart';

class BreedEntity extends Equatable {
  final String id;
  final String name;
  final String altNames;

  final String cfaUrl;
  final String vetstreetUrl;
  final String vcahospitalsUrl;
  final String wikipediaUrl;

  final String temperament;
  final String origin;

  final String description;
  final String lifeSpan;

  final int adaptability;
  final int intelligence;
  final int socialNeeds;
  final int affectionLevel;
  final int childFriendly;
  final int catFriendly;
  final int dogFriendly;
  final int energyLevel;
  final BreedImageEntity image;

  const BreedEntity({
    required this.id,
    required this.name,
    required this.altNames,
    required this.cfaUrl,
    required this.vetstreetUrl,
    required this.vcahospitalsUrl,
    required this.wikipediaUrl,
    required this.temperament,
    required this.origin,
    required this.description,
    required this.lifeSpan,
    required this.adaptability,
    required this.intelligence,
    required this.socialNeeds,
    required this.affectionLevel,
    required this.childFriendly,
    required this.catFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        altNames,
        cfaUrl,
        vetstreetUrl,
        vcahospitalsUrl,
        wikipediaUrl,
        temperament,
        origin,
        description,
        lifeSpan,
        adaptability,
        intelligence,
        socialNeeds,
        affectionLevel,
        childFriendly,
        catFriendly,
        dogFriendly,
        energyLevel,
        image,
      ];
}
