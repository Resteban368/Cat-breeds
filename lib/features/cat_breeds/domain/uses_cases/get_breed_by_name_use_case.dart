import 'package:cats_breeds/core/errors/failures.dart';
import 'package:cats_breeds/core/use_cases.dart/use_cases_interface.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/domain/repositories/repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetBreedByNameUseCase
    implements
        UseCaseInterface<List<BreedEntity>, GetBreedByNameUseCaseParams> {
  final BreedRepositoryInterface breedRepositoryInterface;

  GetBreedByNameUseCase({required this.breedRepositoryInterface});

  @override
  Future<Either<Failure, List<BreedEntity>>> call(
    GetBreedByNameUseCaseParams params,
  ) {
    return breedRepositoryInterface.getBreedByName(params.name);
  }
}

class GetBreedByNameUseCaseParams extends Equatable {
  final String name;
  const GetBreedByNameUseCaseParams({required this.name});
  @override
  List<Object?> get props => [name];
}
