part of 'breed_cubit.dart';

sealed class BreedState extends Equatable {
  const BreedState();

  @override
  List<Object?> get props => [];
}

final class BreedInitial extends BreedState {}

final class BreedLoading extends BreedState {}

final class BreedLoaded extends BreedState {
  final int page;
  final List<BreedEntity> breeds;
  final Map<String, int> activeFilters; // Characteristic -> Minimum Level

  const BreedLoaded({
    required this.breeds,
    required this.page,
    this.activeFilters = const {},
  });

  List<BreedEntity> get filteredBreeds {
    if (activeFilters.isEmpty) return breeds;

    return breeds.where((breed) {
      // Must pass ALL active filters
      for (final entry in activeFilters.entries) {
        final characteristic = entry.key;
        final requiredLevel = entry.value;

        int breedLevel = 0;
        switch (characteristic) {
          case 'Adaptability':
            breedLevel = breed.adaptability;
            break;
          case 'Intelligence':
            breedLevel = breed.intelligence;
            break;
          case 'Social Needs':
            breedLevel = breed.socialNeeds;
            break;
          case 'Affectionate':
            breedLevel = breed.affectionLevel;
            break;
          case 'Child Friendly':
            breedLevel = breed.childFriendly;
            break;
          case 'Cat Friendly':
            breedLevel = breed.catFriendly;
            break;
          case 'Dog Friendly':
            breedLevel = breed.dogFriendly;
            break;
          case 'Energy Level':
            breedLevel = breed.energyLevel;
            break;
        }

        // Exclude if it doesn't meet the minimum level required for this characteristic
        if (breedLevel < requiredLevel) {
          return false;
        }
      }
      return true; // Passed all filters
    }).toList();
  }

  @override
  List<Object?> get props => [breeds, page, activeFilters];
}

final class BreedFailure extends BreedState {
  final String message;
  const BreedFailure({required this.message});

  @override
  List<Object> get props => [message];
}
