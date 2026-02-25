import 'package:cats_breeds/core/theme/app_theme.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/home/widgets/custom_search_app_bar_widget.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_app_bar_widget.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/blocs/breed_managemen/breed_cubit.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/detail_screen/components/body_component.dart'
    as import_body_component;
import 'package:cats_breeds/features/cat_breeds/presentation/widgets/custom_image_network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      preferredSizeValue: 52,
      title: BuildTitleAppBarWidget(title: 'Cat Breeds'),
      actions: [
        IconButton(
          icon: const Icon(Icons.shuffle),
          onPressed: () => _showRandomBreedDialog(context),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            _showFilterDialog(context);
          },
        ),
      ],
      bottom: BuildSearchAppBarWidget(),
    );
  }

  void _showRandomBreedDialog(BuildContext context) async {
    // Show a loading dialog first
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // Fetch random breed
    final breedCubit = context.read<BreedCubit>();
    final randomBreed = await breedCubit.fetchRandomBreed();

    // Close loading dialog
    if (context.mounted) Navigator.pop(context);

    if (randomBreed != null && context.mounted) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Scaffold(
              appBar: AppBar(
                title: Text(randomBreed.name),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(dialogContext),
                ),
              ),
              body: Column(
                children: [
                  Hero(
                    tag: randomBreed.id,
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: CustomNetworkImageWidget(
                        url: randomBreed.image.url,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        import_body_component.BodyComponent(
                          breedEntity: randomBreed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not fetch a random breed.')),
      );
    }
  }

  void _showFilterDialog(BuildContext context) {
    final filters = [
      'Adaptability',
      'Intelligence',
      'Social Needs',
      'Affectionate',
      'Child Friendly',
      'Cat Friendly',
      'Dog Friendly',
      'Energy Level',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return BlocBuilder<BreedCubit, BreedState>(
          // Use the original context's BLoC
          bloc: BlocProvider.of<BreedCubit>(context),
          builder: (contextBuilder, state) {
            Map<String, int> activeFilters = const {};
            if (state is BreedLoaded) {
              activeFilters = state.activeFilters;
            }

            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter by Minimum Characteristic Level',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filters.map((filter) {
                          final currentValue = activeFilters[filter] ?? 0;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$filter: ${currentValue > 0 ? currentValue : 'Off'}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Slider(
                                value: currentValue.toDouble(),
                                min: 0,
                                max: 5,
                                activeColor: AppTheme.orange,
                                inactiveColor: AppTheme.orange2,
                                divisions: 5,
                                label: currentValue > 0
                                    ? currentValue.toString()
                                    : 'Off',
                                onChanged: (double value) {
                                  context.read<BreedCubit>().updateFilter(
                                    filter,
                                    value.toInt(),
                                  );
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<BreedCubit>().clearFilters();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Clear All Filters'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(bottomSheetContext),
                      child: const Text(
                        'Apply Changes & Close',
                        style: TextStyle(color: AppTheme.orange),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
