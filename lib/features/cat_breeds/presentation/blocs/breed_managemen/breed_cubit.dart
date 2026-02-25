// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cats_breeds/core/errors/failures.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/domain/uses_cases/get_breed_by_name_use_case.dart';
import 'package:cats_breeds/features/cat_breeds/domain/uses_cases/get_breeds_use_case.dart';
import 'package:equatable/equatable.dart';

part 'breed_state.dart';

class BreedCubit extends Cubit<BreedState> {
  final GetBreedsUseCase getBreedsUseCase;
  final GetBreedByNameUseCase getBreedByNameUseCase;
  bool _isLoading = false;

  BreedCubit({
    required this.getBreedsUseCase,
    required this.getBreedByNameUseCase,
  }) : super(BreedInitial());

  Future<void> onRefresh() async {
    if (state is BreedLoading) return;
    emit(BreedLoading());
    final result = await getBreedsUseCase(GetBreedsUseCaseParameters(page: 0));
    result.fold(
      (failure) =>
          emit(BreedFailure(message: (failure as ServerFailure).message)),
      (breeds) {
        emit(BreedLoaded(breeds: breeds, page: 0));
      },
    );
  }

  Future<void> onLoad() async {
    if (state is! BreedLoaded || _isLoading) return;
    _isLoading = true;

    final currentState = state as BreedLoaded;
    final nextPage = currentState.page + 1;
    final result = await getBreedsUseCase(
      GetBreedsUseCaseParameters(page: nextPage),
    );
    result.fold(
      (failure) =>
          emit(BreedFailure(message: (failure as ServerFailure).message)),
      (newBreeds) {
        final updatedBreeds = List<BreedEntity>.from(currentState.breeds)
          ..addAll(newBreeds);
        emit(BreedLoaded(breeds: updatedBreeds, page: nextPage));
      },
    );
    _isLoading = false;
  }

  Future<void> getBreedByName(String name) async {
    if (name.isEmpty) {
      await onRefresh();
      return;
    }
    emit(BreedLoading());
    final result = await getBreedByNameUseCase(
      GetBreedByNameUseCaseParams(name: name),
    );
    result.fold(
      (failure) =>
          emit(BreedFailure(message: (failure as ServerFailure).message)),
      (breeds) => emit(BreedLoaded(breeds: breeds, page: 0)),
    );
  }
}
