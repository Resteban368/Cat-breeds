import 'package:cats_breeds/core/errors/failures.dart';
import 'package:cats_breeds/core/use_cases.dart/use_cases_interface.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/domain/repositories/repository_interface.dart';
import 'package:dartz/dartz.dart';

class GetRandomBreedUseCase implements UseCaseInterface<BreedEntity, NoParams> {
  final BreedRepositoryInterface breedRepositoryInterface;

  GetRandomBreedUseCase({required this.breedRepositoryInterface});

  @override
  Future<Either<Failure, BreedEntity>> call(NoParams params) async {
    return await breedRepositoryInterface.getRandomBreed();
  }
}
