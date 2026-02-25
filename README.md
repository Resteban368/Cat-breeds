# Cat Breeds App

¡Bienvenido al repositorio de **Cat Breeds**! Esta es una aplicación móvil desarrollada en Flutter que permite explorar las diferentes razas de gatos interactuando de manera eficiente y escalable con una API moderna.

## 🏗️ Estructura del Proyecto

El proyecto sigue los principios de **Clean Architecture** (Arquitectura Limpia), lo cual asegura un código desacoplado, escalable y mantenible.

El código fuente está organizado principalmente dentro de la carpeta `lib/`:

- **`core/`**: Contiene configuraciones fundamentales, servicios externos (enrutamiento, entorno, peticiones), inyección de dependencias (`get_it`), y utilidades comunes (errores, animaciones, helpers).
- **`features/`**: Divide la aplicación por funcionalidades. Dentro de la funcionalidad principal (`cat_breeds`), se utilizan las tres capas de Clean Architecture:
  - **`data/`**: Modelos, fuentes de datos (Remote/Local) y la implementación de los repositorios.
  - **`domain/`**: Entidades, casos de uso (Use Cases) y contratos (interfaces) de repositorios. Es la capa más pura y no depende de frameworks externos.
  - **`presentation/`**: Componentes de UI, Screens, y los Blocs/Cubits para la gestión de estado.
- **`shared/`**: Widgets, componentes y pantallas globales y reutilizables en cualquier parte de la app (ej. `splash_screen`).

## 🌐 API Consumida

La aplicación consume datos de una API externa (generalmente **The Cat API**) para obtener la información de los felinos.

- Las consultas incluyen parámetros de paginación (`limit`, `page`) y búsqueda por texto (`q`).
- Se utiliza el encabezado `x-api-key` para la autenticación, lo cual está gestionado desde un archivo de entorno `.env` usando la librería `flutter_dotenv` y encapsulado en el `EnvironmentService`.

## ✨ Animaciones y UI/UX

El proyecto prioriza una experiencia de usuario (UX) fluida y moderna:

- **Hero Transitions**: Se emplean animaciones "Hero" al momento de navegar entre la lista de gatos y la pantalla de detalles visuales, permitiendo que la imagen fluya suavemente de un lugar a otro.
- **Shimmer y Carga Progresiva**: Para las imágenes asíncronas se usa un efecto _Shimmer_ como placeholder de carga (gracias a `CachedNetworkImage` y lógica interna) previniendo saltos bruscos en la UI.
- **Micro-animaciones**: Transiciones suaves y componentes pulidos, pensados para dar _feedback_ visual a cada interacción.

## 🎛️ Gestor de Estado

El manejo de estado está construido al 100% sobre el patrón **BLoC** (Business Logic Component).

- Utilizando la dependencia `flutter_bloc`, los eventos de la vista delegan la ejecución hacia la capa de dominio.
- El Bloc procesa la información y emite diferentes _estados_ (Initial, Loading, Loaded, Error) los cuales la interfaz observa (`BlocBuilder` o `BlocConsumer`) para actualizar la pantalla reactivamente.

## 📦 Paquetes Principales y Dependencias

- **`flutter_bloc`**: Base para la gestión de estado reactiva y predecible.
- **`http`**: Cliente HTTP nativo para manejar las llamadas a la REST API.
- **`go_router`**: Librería robusta para manejar la navegación declarativa tipo URL y deep-links.
- **`get_it`**: Localizador de servicios usado para la Inyección de Dependencias, aislando la instanciación de clases.
- **`dartz`**: Permite un estilo de programación funcional, especialmente útil para manejar Errores / Respuestas exitosas (`Either<Failure, Result>`) directamente desde el repositorio.
- **`cached_network_image`**: Gestor avanzado para la carga y cacheo persistente de las imágenes de red.
- **`equatable`**: Facilita la comparación de objetos por valor y no por referencia (fundamental para BLoC).
- **`flutter_dotenv`**: Para cargar variables de entorno seguras en la aplicación local.
- **`google_fonts`**: Proporciona fuentes tipográficas modernas dinámicas de forma sencilla.

## 🔄 Carga de Datos

El flujo de obtención de datos desde la nube hasta la pantalla es el siguiente:

1. **Interacción del Usuario**: El usuario interactúa o abre la aplicación. La interfaz (UI) emite un evento al `Bloc` correspondiente.
2. **Caso de Uso (Use Case)**: El `Bloc` invoca un _Use Case_ específico en la capa de `Domain` (ej: `GetBreedsUseCase`).
3. **Repositorio & Data Source**: El Use Case solicita la información al `RepositoryInterface`, el cual redirige esto al `RemoteDataSource`.
4. **Petición HTTP**: La clase `RemoteDataSourceImplementation` realiza la petición a la URI remota empleando paginación o búsqueda usando `http.Client`.
5. **Decodificación**: Se decodifica el JSON crudo en `Models`. Dichos modelos son luego convertidos (mapped) a sus respectivas `Entities` para la capa de Dominio, y son devueltos al Use Case usando `dartz` (`Right` si fue exitoso, `Left` con un `ServerFailure` si hubo error).
6. **Vista**: El `Bloc` recibe la respuesta y emite el estado `Loaded`, enviando la lista a la página. La UI la renderiza. En caso de aplicar scroll continuo, los datos se acumulan (paginación) sin perder performance.
