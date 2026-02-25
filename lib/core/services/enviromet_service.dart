import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentService {
  final DotEnv dotenv;

  EnvironmentService({required this.dotenv});

  String get apiKey => dotenv.env['x-api-key'] ?? '';
  String get baseUrl => 'api.thecatapi.com';
  String get getBreeds => 'v1/breeds';
  String get getBreedByName => 'v1/breeds/search';
}
