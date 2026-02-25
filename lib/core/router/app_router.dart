import 'package:cats_breeds/features/cat_breeds/domain/entities/breed_entity.dart';
import 'package:cats_breeds/core/animations/navigation_animation.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/detail_screen/detail_screen.dart';
import 'package:cats_breeds/features/cat_breeds/presentation/screens/home/home_screen.dart';
import 'package:cats_breeds/shared/Screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => navigationAnimation(
          context: context,
          page: const HomeScreen(),
          tipeAnimation: TipeAnimation.fade,
        ),
      ),
      GoRoute(
        path: '/detail',
        name: 'detail',
        pageBuilder: (context, state) {
          final breedEntity = state.extra as BreedEntity?;
          return navigationAnimation(
            context: context,
            page: DetailScreen(breedEntity: breedEntity!),
            tipeAnimation: TipeAnimation.fade,
          );
        },
      ),
    ],
  );

  static GoRouter get appRouter => _router;
}
