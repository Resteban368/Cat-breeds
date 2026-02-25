import 'package:cats_breeds/bootstrap.dart';
import 'package:cats_breeds/shared/Screens/app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dependency_injection.dart' as di;

void main() async {
  await dotenv.load(fileName: "assets/.env");
  await di.dependencyInjectionInit();

  bootstrap(() => const MyApp());
}
