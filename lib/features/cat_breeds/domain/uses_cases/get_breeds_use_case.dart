import 'package:cats_breeds/core/errors/failures.dart';
import 'package:cats_breeds/core/use_cases.dart/use_cases_interface.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/domain/repositories/repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetBreedsUseCase
    implements UseCaseInterface<List<BreedEntity>, GetBreedsUseCaseParameters> {
  final BreedRepositoryInterface breedRepositoryInterface;

  GetBreedsUseCase({required this.breedRepositoryInterface});
  @override
  Future<Either<Failure, List<BreedEntity>>> call(
    GetBreedsUseCaseParameters params,
  ) {
    return breedRepositoryInterface.getBreeds(params.page);
  }
}

class GetBreedsUseCaseParameters extends Equatable {
  final int page;
  const GetBreedsUseCaseParameters({required this.page});

  @override
  List<Object?> get props => [page];
}
