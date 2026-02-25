import 'package:cats_breeds/core/theme/app_theme.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_image_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildCardWidget extends StatelessWidget {
  const BuildCardWidget({super.key, required this.breedEntity});

  final BreedEntity breedEntity;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          offset: Offset(1, 1),
          blurRadius: 10,
        ),
      ],
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 250,
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          children: [
            _BuildImageWidget(breedEntity: breedEntity),
            _BuildOptionsWidget(breedEntity: breedEntity),
          ],
        ),
      ),
    );
  }
}

class _BuildOptionsWidget extends StatelessWidget {
  const _BuildOptionsWidget({required this.breedEntity});
  final BreedEntity breedEntity;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.pushNamed('detail', extra: breedEntity);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  color: AppTheme.orange,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Icon(Icons.pets_outlined),
                        Text(
                          'View more',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildImageWidget extends StatefulWidget {
  const _BuildImageWidget({required this.breedEntity});

  final BreedEntity breedEntity;

  @override
  State<_BuildImageWidget> createState() => _BuildImageWidgetState();
}

class _BuildImageWidgetState extends State<_BuildImageWidget> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.horizontal(left: Radius.circular(30));
    return Expanded(
      flex: 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: widget.breedEntity.image.id,
            child: CustomNetworkImageWidget(
              url: widget.breedEntity.image.url,
              borderRadius: borderRadius,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: [0.5, 0.8, 1],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 16,
              children: [
                _buildText(text: widget.breedEntity.name),
                _buildText(text: widget.breedEntity.origin),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildText({required String text}) {
    return Expanded(
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: AppTheme.white),
      ),
    );
  }
}
