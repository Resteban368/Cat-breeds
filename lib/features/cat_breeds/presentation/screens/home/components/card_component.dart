import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/home/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  const CardComponent({super.key, required this.breedEntity});

  final BreedEntity breedEntity;
  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0.8, end: 1),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: BuildCardWidget(breedEntity: widget.breedEntity),
          ),
        );
      },
    );
  }
}
