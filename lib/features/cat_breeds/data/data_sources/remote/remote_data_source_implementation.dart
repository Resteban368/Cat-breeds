import 'dart:convert';

import 'package:cats_breeds/core/errors/exeptions.dart';
import 'package:cats_breeds/core/services/enviromet_service.dart';
import 'package:cats_breeds/features/cat_breeds/data/data_sources/remote/remote_data_source_interface.dart';
import 'package:cats_breeds/features/cat_breeds/data/models/breed_model.dart';
import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:http/http.dart' as http;

class RemoteDataSourceImplementation implements RemoteDataSourceInterface {
  final http.Client cliente;
  final EnvironmentService environmentService;

  RemoteDataSourceImplementation({
    required this.cliente,
    required this.environmentService,
  });

  Future<List<BreedEntity>> _defaultRequest(Uri url) async {
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': environmentService.apiKey,
    };
    final response = await cliente.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final breeds = List<BreedModel>.from(
        data.map((x) => BreedModel.fromMap(x)),
      );
      return breeds;
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<List<BreedEntity>> getBreeds(int page) async {
    final query = {'limit': '10', 'page': page.toString()};

    final url = Uri.https(
      environmentService.baseUrl,
      environmentService.getBreeds,
      query,
    );
    final response = await _defaultRequest(url);

    return response;
  }

  @override
  Future<List<BreedEntity>> getBreedByName(String name) async {
    final query = {'q': name, 'attach_image': '1'};
    final url = Uri.https(
      environmentService.baseUrl,
      environmentService.getBreedByName,
      query,
    );
    final response = await _defaultRequest(url);
    return response;
  }

  @override
  Future<BreedEntity> getRandomBreed() async {
    final query = {'has_breeds': '1', 'limit': '1'};
    final url = Uri.https(
      environmentService.baseUrl,
      environmentService.getRandomBreed,
      query,
    );
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': environmentService.apiKey,
    };
    final response = await cliente.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final imageData = data.first as Map<String, dynamic>;
        final breedsData = imageData['breeds'] as List<dynamic>;
        if (breedsData.isNotEmpty) {
          final breedMap = breedsData.first as Map<String, dynamic>;
          // Acoplar la información de la imagen dentro del mapa de la raza para que el fromMap funcione
          breedMap['image'] = {
            'id': imageData['id'],
            'url': imageData['url'],
            'width': imageData['width'],
            'height': imageData['height'],
          };
          return BreedModel.fromMap(breedMap);
        }
      }
      throw ServerException(message: 'No breed found in the random image');
    } else {
      throw ServerException(message: response.body);
    }
  }
}
