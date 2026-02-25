import 'package:cats_breeds/core/errors/exeptions.dart';
import 'package:cats_breeds/core/errors/failures.dart';
import 'package:cats_breeds/features/cat_breeds/data/data_sources/remote/remote_data_source_interface.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/features/cat_breeds/domain/repositories/repository_interface.dart';
import 'package:dartz/dartz.dart';

class BreedRepositoryImplementation implements BreedRepositoryInterface {
  final RemoteDataSourceInterface remoteDataSourceInterface;

  BreedRepositoryImplementation({required this.remoteDataSourceInterface});

  @override
  Future<Either<Failure, List<BreedEntity>>> getBreeds(int page) async {
    try {
      final response = await remoteDataSourceInterface.getBreeds(page);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<BreedEntity>>> getBreedByName(String name) async {
    try {
      final response = await remoteDataSourceInterface.getBreedByName(name);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BreedEntity>> getRandomBreed() async {
    try {
      final response = await remoteDataSourceInterface.getRandomBreed();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
