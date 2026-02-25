import 'package:cats_breeds/features/cat_breeds/presentation/blocs/breed_managemen/breed_cubit.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/home/components/card_component.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_gif_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyComponent extends StatelessWidget {
  const BodyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedCubit, BreedState>(
      builder: (context, state) {
        switch (state) {
          case BreedInitial():
          case BreedLoading():
            return SliverFillRemaining(
              child: CustomGifWidget(gifName: 'loading'),
            );
          case BreedLoaded():
            final breeds = state.breeds;
            if (breeds.isEmpty) {
              return SliverFillRemaining(
                child: CustomGifWidget(gifName: 'error'),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final breed = breeds[index];
                return CardComponent(breedEntity: breed);
              }, childCount: breeds.length),
            );
          case BreedFailure():
            return SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CustomGifWidget(gifName: 'error'),
                      Text(state.message, textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
