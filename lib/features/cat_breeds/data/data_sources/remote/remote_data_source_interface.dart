import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';

abstract class RemoteDataSourceInterface {
  Future<List<BreedEntity>> getBreeds(int page);
  Future<List<BreedEntity>> getBreedByName(String name);
  Future<BreedEntity> getRandomBreed();
}
