import 'package:cats_breeds/dependency_injection.dart';
import 'package:cats_breeds/features/cat_breeds/data/data_sources/remote/remote_data_source_implementation.dart';
import 'package:cats_breeds/features/cat_breeds/data/data_sources/remote/remote_data_source_interface.dart';
import 'package:cats_breeds/features/cat_breeds/data/repositories/repository_implementation.dart';
import 'package:cats_breeds/features/cat_breeds/domain/repositories/repository_interface.dart';
import 'package:cats_breeds/features/cat_breeds/domain/uses_cases/get_breed_by_name_use_case.dart';
import 'package:cats_breeds/features/cat_breeds/domain/uses_cases/get_breeds_use_case.dart';
import 'package:cats_breeds/features/cat_breeds/domain/uses_cases/get_random_breed_use_case.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/blocs/breed_managemen/breed_cubit.dart';

Future<void> breedDependencyInjection() async {
  // ------------------------ providers ------------------------
  sl
    ..registerLazySingleton<BreedCubit>(
      () => BreedCubit(
        getBreedsUseCase: sl(),
        getBreedByNameUseCase: sl(),
        getRandomBreedUseCase: sl(),
      ),
    )
    // ------------------------ use cases ------------------------
    ..registerLazySingleton<GetBreedsUseCase>(
      () => GetBreedsUseCase(breedRepositoryInterface: sl()),
    )
    ..registerLazySingleton<GetBreedByNameUseCase>(
      () => GetBreedByNameUseCase(breedRepositoryInterface: sl()),
    )
    ..registerLazySingleton<GetRandomBreedUseCase>(
      () => GetRandomBreedUseCase(breedRepositoryInterface: sl()),
    )
    // ------------------------ repositories ------------------------
    ..registerLazySingleton<BreedRepositoryInterface>(
      () => BreedRepositoryImplementation(remoteDataSourceInterface: sl()),
    )
    // ------------------------ datasources ------------------------
    ..registerLazySingleton<RemoteDataSourceInterface>(
      () => RemoteDataSourceImplementation(
        cliente: sl(),
        environmentService: sl(),
      ),
    );
}
