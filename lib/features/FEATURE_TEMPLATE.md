# Feature Template - Clean Architecture

Este template sirve como guía para crear nuevos features o migrar features existentes a Clean Architecture.

## 📁 Estructura de Carpetas

```
lib/features/[feature_name]/
├── data/
│   ├── data_sources/
│   │   ├── remote/
│   │   │   ├── remote_data_source_implementation.dart
│   │   │   └── remote_data_source_interface.dart
│   │   └── local/ (opcional)
│   │       ├── local_data_source_implementation.dart
│   │       └── local_data_source_interface.dart
│   ├── models/
│   │   └── [entity]_model.dart
│   └── repositories/
│       └── repository_implementation.dart
├── domain/
│   ├── entities/
│   │   └── [entity]_entity.dart
│   ├── repositories/
│   │   └── repository_interface.dart
│   └── uses_cases/
│       └── [action]_[entity]_use_case.dart
└── presentation/
    ├── blocs/
    │   └── [feature_name]_management/
    │       ├── [feature_name]_cubit.dart
    │       └── [feature_name]_state.dart
    ├── pages/
    │   └── [feature_name]_page.dart
    ├── widgets/
    │   └── [widget_name]_widget.dart
    └── [feature_name]_inyection.dart
```

---

## 🔄 Pasos para Crear un Feature

### 1. Domain Layer

#### Entities

- Extender de `Equatable`.
- Propiedades finales y constructor const.

```dart
class ProductEntity extends Equatable {
  final String id;
  final String name;

  const ProductEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
```

#### Repository Interface

- Definir el contrato abstracto.
- Usar `Either<Failure, Type>`.

```dart
abstract class ProductRepositoryInterface {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
```

#### Use Cases

- Implementar `UseCaseInterface<Type, Params>`.
- Definir clase de parámetros si es necesario.

```dart
class GetProductsUseCase implements UseCaseInterface<List<ProductEntity>, NoParams> {
  final ProductRepositoryInterface repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) {
    return repository.getProducts();
  }
}
```

### 2. Data Layer

#### Models

- Extender de la entidad del dominio.
- Implementar `fromJson` y `toJson`.

```dart
class ProductModel extends ProductEntity {
  const ProductModel({required super.id, required super.name});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(id: json['id'], name: json['name']);
}
```

#### Data Sources

- Interfaz e implementación separadas.

```dart
abstract class RemoteDataSourceInterface {
  Future<List<ProductModel>> getProducts();
}

class RemoteDataSourceImplementation implements RemoteDataSourceInterface {
  final http.Client cliente;
  final EnvironmentService environmentService;

  RemoteDataSourceImplementation({required this.cliente, required this.environmentService});

  @override
  Future<List<ProductModel>> getProducts() async {
    // Implementación con http y manejo de errores
  }
}
```

#### Repository Implementation

- Implementar interfaz del dominio.
- Convertir excepciones a `Failure`.

```dart
class ProductRepositoryImplementation implements ProductRepositoryInterface {
  final RemoteDataSourceInterface remoteDataSource;

  ProductRepositoryImplementation({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final result = await remoteDataSource.getProducts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

### 3. Presentation Layer

#### Cubit

- Usar `Cubit` en lugar de `Bloc`.
- Inyectar casos de uso.

```dart
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    final result = await getProductsUseCase(NoParams());
    result.fold(
      (failure) => emit(ProductError(message: failure.toString())),
      (products) => emit(ProductLoaded(products: products)),
    );
  }
}
```

#### Dependency Injection (DI)

- Crear archivo `[feature]_inyection.dart`.
- Registrar manualmente en el `GetIt` (usando el global `sl`).

```dart
Future<void> productDependencyInjection() async {
  sl
    ..registerLazySingleton<ProductCubit>(() => ProductCubit(getProductsUseCase: sl()))
    ..registerLazySingleton<GetProductsUseCase>(() => GetProductsUseCase(repository: sl()))
    ..registerLazySingleton<ProductRepositoryInterface>(() => ProductRepositoryImplementation(remoteDataSource: sl()))
    ..registerLazySingleton<RemoteDataSourceInterface>(() => RemoteDataSourceImplementation(cliente: sl(), environmentService: sl()));
}
```

### 4. Inicialización

- Llamar a la función de inyección del feature en `lib/dependency_injection.dart`.

---

## ✅ Checklist de Verificación

- [ ] Entidades extienden `Equatable`.
- [ ] Casos de uso implementan `UseCaseInterface`.
- [ ] Modelos extienden entidades.
- [ ] Repositorios usan interfaces definidas en domain.
- [ ] DI manual configurada en `[feature]_inyection.dart`.
- [ ] Feature inyectado en `dependency_injection.dart`.
