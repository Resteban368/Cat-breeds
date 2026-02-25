import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:flutter/material.dart';

import 'components/app_bar_component.dart';
import 'components/body_component.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.breedEntity});

  final BreedEntity breedEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarComponent(breedEntity: breedEntity),
          BodyComponent(breedEntity: breedEntity),
        ],
      ),
    );
  }
}
