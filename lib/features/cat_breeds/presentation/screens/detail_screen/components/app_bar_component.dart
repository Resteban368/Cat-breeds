import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_app_bar_widget.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_image_network_widget.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key, required this.breedEntity});

  final BreedEntity breedEntity;
  @override
  Widget build(BuildContext context) {
    final double preferredSizeValue = MediaQuery.sizeOf(context).height * 0.4;
    return AppBarWidget(
      preferredSizeValue: preferredSizeValue,
      fixed: true,
      title: BuildTitleAppBarWidget(title: breedEntity.name),
      bottom: Container(
        margin: EdgeInsets.all(0),
        height: preferredSizeValue,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Hero(
            tag: breedEntity.image.id,
            child: CustomNetworkImageWidget(
              url: breedEntity.image.url,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
