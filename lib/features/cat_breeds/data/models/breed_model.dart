// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cats_breeds/features/cat_breeds/data/models/breed_image_model.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';

class BreedModel extends BreedEntity {
  final String id;
  final String name;
  final String altNames;
  final String cfaUrl;
  final String wikipediaUrl;
  final String vetstreetUrl;
  final String vcahospitalsUrl;
  final String temperament;
  final String origin;
  final String countryCodes;
  final String countryCode;
  final String description;
  final String lifeSpan;
  final int indoor;
  final int lap;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int catFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int intelligence;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;
  final int vocalisation;
  final int bidability;
  final int experimental;
  final int hairless;
  final int natural;
  final int rare;
  final int rex;
  final int suppressedTail;
  final int shortLegs;
  final int hypoallergenic;
  final String referenceImageId;
  final BreedImageModel image;

  const BreedModel({
    required this.id,
    required this.name,
    required this.altNames,
    required this.cfaUrl,
    required this.vetstreetUrl,
    required this.vcahospitalsUrl,
    required this.temperament,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.lifeSpan,
    required this.indoor,
    required this.lap,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.catFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.bidability,
    required this.experimental,
    required this.hairless,
    required this.natural,
    required this.rare,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    required this.wikipediaUrl,
    required this.hypoallergenic,
    required this.referenceImageId,
    required this.image,
  }) : super(
         id: id,
         name: name,
         altNames: altNames,
         cfaUrl: cfaUrl,
         vetstreetUrl: vetstreetUrl,
         vcahospitalsUrl: vcahospitalsUrl,
         wikipediaUrl: wikipediaUrl,
         temperament: temperament,
         origin: origin,
         intelligence: intelligence,
         description: description,
         lifeSpan: lifeSpan,
         adaptability: adaptability,
         socialNeeds: socialNeeds,
         affectionLevel: affectionLevel,
         childFriendly: childFriendly,
         catFriendly: catFriendly,
         dogFriendly: dogFriendly,
         energyLevel: energyLevel,
         image: image,
       );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "alt_names": altNames,
      "cfa_url": cfaUrl,
      "vetstreet_url": vetstreetUrl,
      "vcahospitals_url": vcahospitalsUrl,
      "temperament": temperament,
      "origin": origin,
      "country_codes": countryCodes,
      "country_code": countryCode,
      "description": description,
      "life_span": lifeSpan,
      "indoor": indoor,
      "lap": lap,
      "adaptability": adaptability,
      "affection_level": affectionLevel,
      "child_friendly": childFriendly,
      "dog_friendly": dogFriendly,
      "energy_level": energyLevel,
      "grooming": grooming,
      "health_issues": healthIssues,
      "intelligence": intelligence,
      "shedding_level": sheddingLevel,
      "social_needs": socialNeeds,
      "stranger_friendly": strangerFriendly,
      "vocalisation": vocalisation,
      "experimental": experimental,
      "hairless": hairless,
      "natural": natural,
      "rare": rare,
      "rex": rex,
      "suppressed_tail": suppressedTail,
      "short_legs": shortLegs,
      "wikipedia_url": wikipediaUrl,
      "hypoallergenic": hypoallergenic,
      "reference_image_id": referenceImageId,
      "cat_friendly": catFriendly,
      "bidability": bidability,
      "image": image.toMap(),
    };
  }

  factory BreedModel.fromMap(Map<String, dynamic> map) {
    return BreedModel(
      id: map['id'] as String,
      name: map["name"] ?? '',
      cfaUrl: map["cfa_url"] ?? '',
      vetstreetUrl: map["vetstreet_url"] ?? '',
      vcahospitalsUrl: map["vcahospitals_url"] ?? '',
      temperament: map["temperament"] ?? '',
      origin: map["origin"] ?? '',
      countryCodes: map["country_codes"] ?? '',
      countryCode: map["country_code"] ?? '',
      description: map["description"] ?? '',
      lifeSpan: map["life_span"] ?? '',
      indoor: map["indoor"] ?? 0,
      lap: map["lap"] ?? 0,
      altNames: map["alt_names"] ?? '',
      adaptability: map["adaptability"] ?? 0,
      affectionLevel: map["affection_level"] ?? 0,
      childFriendly: map["child_friendly"] ?? 0,
      dogFriendly: map["dog_friendly"] ?? 0,
      energyLevel: map["energy_level"] ?? 0,
      grooming: map["grooming"] ?? 0,
      healthIssues: map["health_issues"] ?? 0,
      intelligence: map["intelligence"] ?? 0,
      sheddingLevel: map["shedding_level"] ?? 0,
      socialNeeds: map["social_needs"] ?? 0,
      strangerFriendly: map["stranger_friendly"] ?? 0,
      vocalisation: map["vocalisation"] ?? 0,
      experimental: map["experimental"] ?? 0,
      hairless: map["hairless"] ?? 0,
      natural: map["natural"] ?? 0,
      rare: map["rare"] ?? 0,
      rex: map["rex"] ?? 0,
      suppressedTail: map["suppressed_tail"] ?? 0,
      shortLegs: map["short_legs"] ?? 0,
      wikipediaUrl: map["wikipedia_url"] ?? '',
      hypoallergenic: map["hypoallergenic"] ?? 0,
      referenceImageId: map["reference_image_id"] ?? '',
      catFriendly: map["cat_friendly"] ?? 0,
      bidability: map["bidability"] ?? 0,
      image: map['image'] != null
          ? BreedImageModel.fromMap(map['image'] as Map<String, dynamic>)
          : BreedImageModel(id: '', width: 0, height: 0, url: ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory BreedModel.fromJson(String source) =>
      BreedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
