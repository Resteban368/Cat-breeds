import 'package:cats_breeds/features/cat_breeds/presentation/breed_inyection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/services/enviromet_service.dart';

final sl = GetIt.instance;

Future<void> dependencyInjectionInit() async {
  sl
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => EnvironmentService(dotenv: dotenv));

  await breedDependencyInjection();
}
